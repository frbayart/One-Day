import _mysql
db=_mysql.connect("FIXME_HOST","FIXME_USER","FIXME_PASS","FIXME_DB")
print db.info()
r = db.query('select domainname from domains_list limit 0, 10 ')
# r=db.store_result()
for o in r.fetch_row():
	print o[0]
	

print 'hello'