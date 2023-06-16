class TableBuilder:
    table = None
    
    @classmethod
    def get_table(cls):
        if cls.table is None:
            cls.table = cls.build_table()

        return cls.table

    @classmethod
    def build_table(cls):
        raise NotImplementedError()

class UsuarioBuilder(TableBuilder):
    @classmethod
    def build_table(cls):
        pass
