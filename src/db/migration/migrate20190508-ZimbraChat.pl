#!/usr/bin/perl
#
# ***** BEGIN LICENSE BLOCK *****
# Zimbra Collaboration Suite Server
# Copyright (C) 2015, 2016 Synacor, Inc.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software Foundation,
# version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
# ***** END LICENSE BLOCK *****
#

use strict;
use Migrate;

Migrate::verifySchemaVersion(109);

my $sqlStmt = <<_SQL_;

ALTER TABLE chat.`USER`
    ADD `LAST_SEEN`      BIGINT DEFAULT NULL,
    ADD `STATUS_MESSAGE` VARCHAR(256) NOT NULL DEFAULT '',
    ADD `IMAGE`          MEDIUMBLOB DEFAULT NULL;

ALTER TABLE chat.`CHANNEL`
    ADD `IMAGE`          MEDIUMBLOB DEFAULT NULL;

ALTER TABLE chat.`GROUP`
    ADD `IMAGE`          MEDIUMBLOB DEFAULT NULL;

ALTER TABLE chat.`SPACE`
    ADD `NAME`           VARCHAR(256) NOT NULL DEFAULT '';

UPDATE chat.SPACE
SET SPACE.NAME = SUBSTRING_INDEX(SPACE.ADDRESS, '@', 1);

_SQL_

Migrate::runSql($sqlStmt);

Migrate::updateSchemaVersion(108, 109);

exit(0);