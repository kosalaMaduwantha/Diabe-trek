# this will be used as the base class of the db connections
import pymysql as pymysql


class DB_CONN:
    global_user = "root"
    global_password = "kosalaMA19#"
    global_host = "localhost"
    global_port = 3306
    global_db = "physicalact"
    connection = None
    cursor = None

    # get mysql connection object.
    def open_mysql_connection(self):
        self.connection = pymysql.connect(user=self.global_user, password=self.global_password, host=self.global_host,
                                     port=self.global_port, database=self.global_db, use_unicode=True)
        return self.connection





