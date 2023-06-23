import requests
import random
from datetime import date, timedelta
from pypika import Query

class Table:
    def __init__(self, name, columns, rows):
        self.name = name
        self.columns = columns
        self.rows = rows

    def __str__(self):
        def format(sql):
            return (
                sql
                .replace("),(", "),\n(")
                .replace("VALUES ", "VALUES\n")
            )

        return format(
            Query
            .into(self.name)
            .columns(*self.columns)
            .insert(*self.rows)
            .get_sql()
        )

class TableBuilder:
    table = None

    @classmethod
    def length(cls):
        return len(cls.get_table().rows)
    
    @classmethod
    def get_table(cls) -> Table:
        if cls.table is None:
            cls.build_table()
            print("Building table", cls.table.name)

        return cls.table

    @classmethod
    def build_table(cls):
        raise NotImplementedError()

class UsuarioBuilder(TableBuilder):
    num_users = 500

    class RandomUserApi:
        @classmethod
        def get_users(cls, params):
            response = requests.get("https://randomuser.me/api/", params = params)

            if response.status_code != 200:
                raise Exception("Não foi possível obter os usuários")

            return response.json()["results"]

        @classmethod
        def extract_iso_date(cls, iso_date):
            return iso_date.split("T")[0]

    @classmethod
    def build_table(cls):
        users = cls.RandomUserApi.get_users({
            "inc": "name,email,login,dob,registered",
            "results": cls.num_users,
            "nat": "br",
        })

        cls.table = Table(
            name = "usuario",
            columns = ["nome", "email", "senha", "data_nasc", "data_ingresso"],
            rows = [
                (
                    user["name"]["first"] + " " + user["name"]["last"],
                    user["email"],
                    user["login"]["password"],
                    cls.RandomUserApi.extract_iso_date(user["dob"]["date"]),
                    cls.RandomUserApi.extract_iso_date(user["registered"]["date"])
                )
                for user
                in users
            ]
        )

class AmizadeBuilder(TableBuilder):
    num_friendships = 500 

    @classmethod
    def get_random_friendship(cls):
        num_users = UsuarioBuilder.length()

        rem, dest = None, None

        while rem == dest:
            rem, dest = random.sample(range(1, num_users + 1), 2)

        return (rem, dest)

    @classmethod
    def build_table(cls):
        cls.table = Table(
            name = "amizade",
            columns = ["id_remetente", "id_destinatario"],
            rows = [
                cls.get_random_friendship()
                for _
                in range(cls.num_friendships)
            ]
        )

class DocumentoBuilder(TableBuilder):
    num_docs_per_user = 30 

    @classmethod
    def get_random_type(cls):
        types = [
            "PLANILHA",
            "APRESENTACAO",
            "DOCUMENTO_TEXTO",
            "FORMULARIO"
        ]

        return random.choice(types)

    @classmethod
    def get_random_date(cls, start: date, end: date):
        delta = end - start

        random_days = random.randint(0, delta.days)

        random_date = start + timedelta(days = random_days)

        return random_date.strftime("%Y-%m-%d")

    @classmethod
    def generate_docs_for_user(cls, user_id: int) -> list:
        docs = []

        for i in range(cls.num_docs_per_user):
            docs.append((
                user_id,
                cls.get_random_type(),
                f"Documento {i}",
                f"Descrição {i}",
                cls.get_random_date(
                    start = date(2023, 1, 1),
                    end = date(2023, 12, 31)
                )
            ))

        return docs

    @classmethod
    def build_table(cls):
        num_users = UsuarioBuilder.length()

        rows = []

        # Assumimos que os usuários possuem ids sequenciais, começando em 1
        for id in range(1, num_users + 1):
            rows.extend(cls.generate_docs_for_user(id))

        cls.table = Table(
            name = "documento",
            columns = ["id_dono", "tipo", "nome", "descricao", "data_criacao"],
            rows = rows
        )

class ContribuicaoBuilder(TableBuilder):
    num_contributions_per_doc = 10

    @classmethod
    def generate_contributions_for_doc(cls, doc_id: int) -> list:
        contribs = set() 

        while len(contribs) < cls.num_contributions_per_doc:
            contribs.add((
                doc_id,
                random.randint(1, UsuarioBuilder.length())
            ))

        return contribs

    @classmethod
    def build_table(cls):
        num_docs = DocumentoBuilder.length()

        rows = []

        for id in range(1, num_docs + 1):
            rows.extend(cls.generate_contributions_for_doc(id))

        cls.table = Table(
            name = "contribuicao",
            columns = ["id_documento", "id_usuario"],
            rows = rows
        )

class DocumentoFilter:
    @classmethod
    def filter(cls, type: str) -> list:
        docs = DocumentoBuilder.get_table().rows

        TYPE_INDEX = 1

        return [
            (id, doc)
            for id, doc
            in enumerate(docs, start = 1)
            if doc[TYPE_INDEX] == type
        ]

class PlanilhaBuilder(TableBuilder):
    @classmethod
    def build_table(cls):
        sheets = DocumentoFilter.filter("PLANILHA")

        rows = []

        for id, _ in sheets: 
            rows.append((
                id,
                random.randint(1, 100),
                random.randint(1, 100)
            ))

        cls.table = Table(
            name = "planilha",
            columns = ["id_documento", "largura_linhas", "largura_colunas"],
            rows = rows
        )

class DocumentoTextoBuilder(TableBuilder):
    @classmethod
    def get_random_font(cls):
        fonts = [
            "ARIAL",
            "TIMES_NEW_ROMAN",
            "COURIER_NEW",
        ]

        return random.choice(fonts)

    @classmethod
    def get_random_font_size(cls):
        return random.randint(8, 72)
    
    @classmethod
    def build_table(cls):
        docs = DocumentoFilter.filter("DOCUMENTO_TEXTO")

        rows = []

        for id, _ in docs: 
            rows.append((
                id,
                cls.get_random_font(),
                cls.get_random_font_size()
            ))

        cls.table = Table(
            name = "documento_texto",
            columns = ["id_documento", "fonte", "tamanho_fonte"],
            rows = rows
        ) 

class FormularioBuilder(TableBuilder):
    @classmethod
    def get_random_limit_date(cls):
        return DocumentoBuilder.get_random_date(
            start = date(2024, 1, 1),
            end = date(2024, 12, 31)
        )

    @classmethod
    def build_table(cls):
        forms = DocumentoFilter.filter("FORMULARIO")

        rows = []

        for id, _ in forms: 
            rows.append((
                id,
                cls.get_random_limit_date()
            ))

        cls.table = Table(
            name = "formulario",
            columns = ["id_documento", "data_limite"],
            rows = rows
        )

class PerguntaBuilder(TableBuilder):
    num_questions_per_form = 20

    @classmethod
    def get_questions_for_form(cls, form_id: int) -> list:
        questions = []

        for i in range(cls.num_questions_per_form):
            questions.append((
                form_id,
                f"Pergunta {i}?"
            ))

        return questions

    @classmethod
    def build_table(cls):
        forms = DocumentoFilter.filter("FORMULARIO")

        rows = []

        for id, _ in forms:
            rows.extend(cls.get_questions_for_form(id))

        cls.table = Table(
            name = "pergunta",
            columns = ["id_formulario", "conteudo"],
            rows = rows
        ) 

class RespostaBuilder(TableBuilder):
    num_answers_per_question = 20 

    @classmethod
    def get_answers_for_question(cls, question_id: int) -> list:
        answers = []

        for i in range(cls.num_answers_per_question):
            answers.append((
                question_id,
                random.randint(1, UsuarioBuilder.length()),
                f"Resposta {i}"
            ))

        return answers

    @classmethod
    def build_table(cls):
        num_questions = PerguntaBuilder.length()

        rows = []

        for id in range(1, num_questions + 1):
            rows.extend(cls.get_answers_for_question(id))

        cls.table = Table(
            name = "resposta",
            columns = ["id_pergunta", "id_usuario", "conteudo"],
            rows = rows
        )

class ApresentacaoBuilder(TableBuilder):
    @classmethod
    def build_table(cls):
        presentations = DocumentoFilter.filter("APRESENTACAO")

        rows = []

        for id, _ in presentations:
            rows.append((
                id,
                f"Objetivo {id}"
            ))

        cls.table = Table(
            name = "apresentacao",
            columns = ["id_documento", "objetivo"],
            rows = rows
        )

class Seeder:
    @classmethod
    def seed(cls, tables: list, filepath: str = "seeds.sql"):
        with open(filepath, "w") as f:
            content = "\n\n".join([
                str(table) + ";"
                for table
                in tables
            ])

            f.write(content)

Seeder.seed(
    tables = [
        UsuarioBuilder.get_table(),
        AmizadeBuilder.get_table(),
        DocumentoBuilder.get_table(),
        ContribuicaoBuilder.get_table(),
        # PlanilhaBuilder.get_table(),
        # DocumentoTextoBuilder.get_table(),
        # FormularioBuilder.get_table(),
        PerguntaBuilder.get_table(),
        RespostaBuilder.get_table(),
        # ApresentacaoBuilder.get_table(),
    ],
    filepath = "parte_1_refeita/dml.sql"
)
