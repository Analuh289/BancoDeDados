CREATE DATABASE [paciente]  ON (NAME = N'paciente_data', FILENAME = N'D:\Bancos_Fumec\paciente_data_01.mdf' , SIZE = 7, FILEGROWTH = 10%)
                           LOG ON (NAME = N'paciente_log', FILENAME = N'D:\Bancos_Fumec\paciente_log_01.ldf' , SIZE = 7, FILEGROWTH = 10%)
 COLLATE Latin1_General_CI_AS
GO

use [Paciente]
GO

--CRIA AS TABELAS
CREATE TABLE dbo.cidade (
	codcidade	smallint NOT NULL ,
	cidade		varchar (30) NOT NULL,
	uf		char(2) NOT NULL
);
GO

CREATE TABLE dbo.especialid (
	codespecialid		smallint NOT NULL ,
	especialid		varchar (30) NOT NULL 
);
GO


CREATE TABLE dbo.paciente (
	codpaciente	smallint NOT NULL ,
	paciente	nvarchar (40) NOT NULL ,
	cpf		char(11) NOT NULL,
	sexo		char(10) NOT NULL,
	idade		smallint NOT NULL,
	codcidade	smallint NOT NULL,
);
GO


CREATE TABLE dbo.medico (
	codmedico	smallint NOT NULL ,
	medico		nvarchar (40) NOT NULL ,
	codespecialid	smallint NOT NULL
	
);
GO


CREATE TABLE dbo.consulta (
	codmedico	smallint NOT NULL ,
	codpaciente	smallint NOT NULL ,
	dtconsulta	date NOT NULL ,
	hrconsulta	time NOT NULL ,
	valor		numeric(8,2) NOT NULL
);
GO


--CRIA AS PKs
ALTER TABLE dbo.cidade WITH NOCHECK ADD CONSTRAINT cidade_codcidade_PK PRIMARY KEY  (codcidade);
ALTER TABLE dbo.especialid WITH NOCHECK ADD CONSTRAINT especialid_codespecialid_PK PRIMARY KEY (codespecialid);
ALTER TABLE dbo.paciente WITH NOCHECK ADD CONSTRAINT paciente_codpaciente_PK PRIMARY KEY  (codpaciente);
ALTER TABLE dbo.medico WITH NOCHECK ADD CONSTRAINT medico_codmedico_PK PRIMARY KEY (codmedico);
ALTER TABLE dbo.consulta WITH NOCHECK ADD CONSTRAINT consulta_codmedico_paciente_PK PRIMARY KEY (codmedico,codpaciente);
GO

--CRIA AS FKs
ALTER TABLE dbo.paciente ADD CONSTRAINT paciente_cidade_fk FOREIGN KEY (codcidade) REFERENCES dbo.cidade (codcidade);
ALTER TABLE dbo.medico ADD CONSTRAINT medico_codespecialid_fk FOREIGN KEY (codespecialid) REFERENCES dbo.especialid (codespecialid);
ALTER TABLE dbo.consulta ADD CONSTRAINT consulta_codmedico_fk FOREIGN KEY (codmedico) REFERENCES dbo.medico (codmedico);
ALTER TABLE dbo.consulta ADD CONSTRAINT consulta_codpaciente_fk FOREIGN KEY (codpaciente) REFERENCES dbo.paciente (codpaciente);
GO


--CRIA AS UNIQUEs
ALTER TABLE dbo.cidade ADD CONSTRAINT cidade_cidade_UQ UNIQUE (cidade);
ALTER TABLE dbo.especialid ADD CONSTRAINT especialid_especialid_UQ UNIQUE (especialid);
ALTER TABLE dbo.paciente ADD CONSTRAINT paciente_paciente_UQ UNIQUE (paciente);
ALTER TABLE dbo.medico ADD CONSTRAINT medico_medico_UQ UNIQUE (medico);
GO

--CRIA AS DEFAULTs
ALTER TABLE dbo.consulta ADD CONSTRAINT consuta_valor_ck CHECK (valor >= 130.00);
GO

--CRIA OS CHECKs
ALTER TABLE dbo.paciente ADD CONSTRAINT paciente_sexo_ck CHECK (sexo = 'Masculino' or sexo = 'Feminino');
ALTER TABLE dbo.consulta ADD CONSTRAINT consulta_hrconsulta_ck CHECK (hrconsulta >= '07:30' and hrconsulta <= '18:00');

GO


