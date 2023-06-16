DATABASE = $(database)
USERNAME = $(username)
PASSWORD = $(password)

SCRIPTS = \
	parte_2/parte_1_refeita/ddl.sql \
	parte_2/item_a/triggers.sql \
	parte_3/seeds.sql \
	parte_2/item_b/visao.sql \
	parte_2/item_c/visao.sql \

EXECUTAR_SCRIPTS: $(SCRIPTS)
	@$(foreach script, $^, \
		PGPASSWORD=$(PASSWORD) psql -U $(USERNAME) -d $(DATABASE) -f $(script); \
	)

db: EXECUTAR_SCRIPTS
