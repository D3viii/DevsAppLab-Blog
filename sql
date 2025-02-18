SELECT DISTINCT 
    'PRINCIPAL' AS PRINCIPALID,  
    CASE 
        WHEN (pu.username LIKE 'ADX%' OR pu.username LIKE 'X%' OR pu.username LIKE 'G_%') 
        THEN 'PERSON'
        ELSE 'PROCESSING' 
    END AS PROCESSING_STATUS,  

    TRIM(pu.username) AS COMITID,  

    CASE 
        WHEN (pu.username LIKE 'ADX%' OR pu.username LIKE 'X%' OR pu.username LIKE 'G_%') 
        THEN 'APPNATIVE' 
    END AS PORTAL_ACCESS,  

    CASE 
        WHEN pu.PORTAL_ACCESS IS NULL THEN 'NO' 
        ELSE 'YES' 
    END AS PORTAL_ACCESS_FLAG,  

    DECODE(TRIM(pu.ACCOUNT_STATE),  
        'Locked', 'Locked',  
        'Unlocked', 'Unlocked',  
        'Disabled', 'Disabled') 
    AS ACCOUNT_STATE,  

    TO_CHAR(pu.LAST_OP_TIME, 'YYYY-MM-DD HH24:MI:SS') AS LAST_LOGIN,  
    TO_CHAR(pu.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') AS CREATE_DATE,  
    pu.LOGINS AS LOGINS,  
    pu.DESCRIPTION AS DESCRIPTION,  

    TRIM(ecr.center_role_name) AS PACE_USER_ROLE,  

    TRIM(bizgrp.group_name) AS "STAR and Business Groups"  

FROM pace_masterdbo.pace_users pu  
LEFT JOIN pace_masterdbo.EGL_CENTER_ROLE_USER ecr  
    ON TRIM(pu.username) = TRIM(ecr.username)  
LEFT JOIN pace_masterdbo.egl_center_role ecr_role  
    ON ecr_role.role_id = ecr.center_role_id  
LEFT JOIN pace_masterdbo.PACE_USERS_ROLE_DETAILS purd  
    ON purd.pace_user_id = pu.username  
LEFT JOIN pace_masterdbo.biz_group bizgrp  
    ON purd.role_id = bizgrp.group_id  

ORDER BY pu.username;