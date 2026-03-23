use master
BACKUP DATABASE [paciente] TO  DISK = N'D:\Bancos_Fumec\bkp_full_paciente_sqlserver2014'
	WITH NOFORMAT,
	NOINIT,
	NAME = N'bkp_full_paciente_sqlserver2014',
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
