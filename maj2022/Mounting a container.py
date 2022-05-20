# Databricks notebook source
# MAGIC %fs
# MAGIC ls mnt

# COMMAND ----------



# COMMAND ----------

# MAGIC %fs ls mnt/raspdata

# COMMAND ----------

mntName="raspdata"
storageAccountName="datalakesu20220419"
containerName="raspberry"
#conf_key="fs.azure.account.key.<storage-account-name>.blob.core.windows.net"
#conf_key=fs.azure.sas.<container-name>.<storage-account-name>.blob.core.windows.net
conf_key=f"fs.azure.sas.{containerName}.{storageAccountName}.blob.core.windows.net"

scopeName="MySecretScope"
keyName="raspberrySAS"


# COMMAND ----------

# vi har lavet en SAS via Azure Data Explorer : ?sv=2021-04-10&st=2022-04-19T13%3A04%3A20Z&se=2032-04-20T13%3A04%3A00Z&sr=c&sp=rl&sig=m27wdCS2%2FkP2vCv3nsu91ispHxGRATJefOODtj2khYA%3D
#  vi har lavet raspberrySAS i Azure keyvault som en secret
# vi laver en secret via mystisk url: https://adb-1223120687377482.2.azuredatabricks.net/?o=1223120687377482#secrets/createScope

# COMMAND ----------

print(conf_key)

# COMMAND ----------

dbutils.secrets.get(scope = scopeName, key = keyName)

# COMMAND ----------

dbutils.fs.mount(
  source = f"wasbs://{containerName}@{storageAccountName}.blob.core.windows.net",
  mount_point = f"/mnt/{mntName}",
  extra_configs = {conf_key:dbutils.secrets.get(scope = scopeName, key = keyName)})

# COMMAND ----------

# MAGIC %fs ls /mnt/raspdata

# COMMAND ----------

# File location and type
file_location = "/mnt/raspdata/sensor=1984/year=2022/month=04/*.csv"
file_type = "csv"

# CSV options
infer_schema = "true"
first_row_is_header = "true"
delimiter = ","

# The applied options are for CSV files. For other file types, these will be ignored.
df = spark.read.format(file_type) \
  .option("inferSchema", infer_schema) \
  .option("header", first_row_is_header) \
  .option("sep", delimiter) \
  .load(file_location)

display(df)

# COMMAND ----------

df.count()