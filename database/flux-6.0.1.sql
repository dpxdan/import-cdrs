DROP TABLE IF EXISTS `login_activity_report`;

CREATE TABLE `login_activity_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `country_name` varchar(200) NOT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `login_activity_report` VALUES (1,1,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36','','::1','2021-05-12 07:46:07');

DROP TABLE IF EXISTS `activity_reports`;

CREATE TABLE `activity_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accountid` int NOT NULL,
  `reseller_id` int NOT NULL DEFAULT '1',
  `last_did_call_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_outbound_call_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `balance` varchar(40) NOT NULL,
  `credit_limit` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accountid` (`accountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `menu_modules` (`id`, `menu_label`, `module_name`, `module_url`, `menu_title`, `menu_image`, `menu_subtitle`, `priority`) VALUES(NULL, 'Activity Report', 'activity_report', 'activity_report/activityReport/', 'Reports', "Activity-Reports.png", '0', 82.1);

INSERT INTO `roles_and_permission` (`id`, `login_type`, `permission_type`, `menu_name`, `module_name`, `sub_module_name`, `module_url`, `display_name`, `permissions`, `status`, `creation_date`, `priority`) VALUES
(NULL, 0, 0, 'reports','activity_report','0','activityReport', 'Call Activity Report', '["main","list","search","export"]', 0, '2019-01-25 09:01:03', '9.96000'); 

UPDATE userlevels SET module_permissions = concat( module_permissions, ',', (  SELECT max( id ) FROM menu_modules WHERE module_url = 'activity_report/activityReport/' ) ) WHERE userlevelid = -1;

update `system` set comment='Set Mail Log Path Here' where display_name='Mail Log';
-- Flux UPDATE-944
ALTER TABLE `trunks` ADD COLUMN `sip_cid_type` VARCHAR(50) NOT NULL COMMENT 'none:- None, rpid :- Remote-Party-ID, pid :- P-Asserted-Identity';
-- END

-- Flux UPDATE-945
  ALTER TABLE `sip_devices` ADD COLUMN `codec` varchar(100) NOT NULL AFTER `dir_vars`;
-- End

-- Flux UPDATE-942
update `system` set value='6.0' where name='version';
-- End

-- Flux UPDATE-975
ALTER TABLE `system` CHANGE `sub_group` `sub_group` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
UPDATE `system` SET `sub_group`='Alert Notifications' WHERE `name` = 'alert_notications';
-- Flux UPDATE-975


-- Flux UPDATE-978
CREATE TABLE `automated_report_log` ( 
  `id` int(11) AUTO_INCREMENT primary key NOT NULL, 
  `filename` varchar(100) NULL , 
  `usercode` varchar(50)  NULL , 
  `creation_date` datetime NOT NULL,
  `purge_date` date NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `system` (`id`,`name`, `display_name`, `value`, `field_type`, `comment`, `timestamp`, `reseller_id`, `is_display`, `group_title`, `sub_group`, `field_rules`) VALUES(NULL,'automated_report_attachment_deleted','Delete Automated Report Attachment After Days','1','default_system_input','Here -1 means disable and any positive value means that much of days.All attachment will delete from folder after selected time here.','0000-00-00 00:00:00',0,0,'purge','','');
-- Flux UPDATE-978

-- Flux UPDATE-1039
update menu_modules set menu_label='My Order' where module_url='user/user_products_list/';
-- End


-- Flux UPDATE-1180
ALTER TABLE automated_report_log MODIFY purge_date DATE NULL;
-- Flux UPDATE-1180

-- Flux UPDATE-1028
UPDATE default_templates SET template='<p>Dear #NAME#,</p>\n\n<p>The product #PRODUCT_NAME# has now been added to your account.</p>\n\n<p><strong>Product Information: </strong></p>\n\n<p>Product Name: #PRODUCT_NAME#<br />\nProduct Category: #PRODUCT_CATEGORY#<br />\nPayment Method: #PAYMENT_METHOD#<br />\nProduct Amount: #PRODUCT_AMOUNT#<br />\nNext Bill Date: #NEXT_BILL_DATE#<br />\nQuantity:#QUANTITY#<br />\nTotal Amount:#TOTAL_PRICE# </p>\n\n<p>You can always let us know if you have any question at #COMPANY_EMAIL#. We will be happy to help!</p>\n\n<p>Thanks,<br />\n#COMPANY_NAME#</p>\n' WHERE name='product_purchase';
-- Flux UPDATE-1028
