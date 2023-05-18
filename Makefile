DATABASE = $(database)
USERNAME = $(username)
PASSWORD = $(password)

SCRIPTS = \
	parte_2/parte_1_refeita/ddl.sql \
	parte_2/item_a/triggers.sql \
	parte_2/parte_1_refeita/dml.sql \
	parte_2/item_b/visao.sql \

EXECUTAR_SCRIPTS: $(SCRIPTS)
	@$(foreach script, $^, \
		PGPASSWORD=$(PASSWORD) psql -U $(USERNAME) -d $(DATABASE) -f $(script); \
	)

db: EXECUTAR_SCRIPTS
