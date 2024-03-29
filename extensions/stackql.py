from __future__ import print_function
import pandas as pd
import json
from io import StringIO
from string import Template
from pystackql import StackQL

stackql = StackQL(download_dir='/srv/stackql')

@magics_class
class StackqlMagic(Magics):

    def get_rendered_query(self, data):
        t = Template(StringIO(data).read())
        rendered = t.substitute(self.shell.user_ns)
        return rendered

    def run_query(self, query):
        return pd.read_json(stackql.execute(query))

    def run_cmd(self, query):
        return stackql.executeStmt(query)        

    @line_cell_magic
    def stackql(self, line, cell=None):
        if cell is None:
            results = self.run_query(self.get_rendered_query(line))
        else:
            results = self.run_query(self.get_rendered_query(cell))
        return results

    @line_cell_magic
    def stackql_cmd(self, line, cell=None):
        if cell is None:
            results = self.run_cmd(self.get_rendered_query(line))
        else:
            results = self.run_cmd(self.get_rendered_query(cell))
        return results                    

def load_ipython_extension(ipython):
    """
    Any module file that define a function named `load_ipython_extension`
    can be loaded via `%load_ext module.path` or be configured to be
    autoloaded by IPython at startup time.
    """
    ipython.register_magics(StackqlMagic)

