﻿IF  (IndexProperty(Object_Id('dbo.editions'),'Publicationid_index','IndexID') IS NOT NULL)
	DROP INDEX Publicationid_index ON dbo.editions
IF  (IndexProperty(Object_Id('dbo.prices'),'Editionid_index','IndexID') IS NOT NULL)
	DROP INDEX editionid_index ON dbo.prices
IF  (IndexProperty(Object_Id('dbo.Discounts'),'Storid_index','IndexID') IS NOT NULL)
	drop INDEX Storid_index ON dbo.Discounts
IF  (IndexProperty(Object_Id('dbo.TagTitle'),'Titleid_index','IndexID') IS NOT NULL)
	Drop INDEX Titleid_index ON dbo.TagTitle
IF  (IndexProperty(Object_Id('dbo.TagTitle'),'TagName_index','IndexID') IS NOT NULL)
	Drop INDEX TagName_index ON dbo.TagTitle
IF  (IndexProperty(Object_Id('dbo.employee'),'pub_id_index','IndexID') IS NOT NULL)
	Drop INDEX pub_id_index ON dbo.employee
IF  (IndexProperty(Object_Id('dbo.publications'),'pubid_index','IndexID') IS NOT NULL)
	Drop  INDEX pubid_index ON dbo.publications
GO