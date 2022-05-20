select		*
from			sys.firewall_rules

--Microsoft SQL Azure (RTM) - 12.0.2000.8   Feb 23 2022 11:32:53   Copyright (C) 2021 Microsoft Corporation 
SELECT @@version

-- session 51 på AdvCloud
USE master
-- sessionid 90 på masteren
SELECT @@spid


SELECT		*
FROM		saleslt.customer

BEGIN TRANSACTION
	UPDATE saleslt.customer
	SET middleName='Ballade'
	WHERE customerId=1

-- session id 80 før skalering
SELECT		*
FROM		saleslt.customer
-- nu hedder vi sessionid 70

select	*
from	sys.dm_exec_sessions
where session_id=79


