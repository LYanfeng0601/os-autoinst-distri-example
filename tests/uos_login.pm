# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
#
# UOS 登录步骤：等待登录界面或已进入桌面，若在登录界面则输入凭据并登录。
# 需配合 needles：uos-login（登录界面）、uos-desktop（桌面）。

use Mojo::Base 'basetest';
use testapi;

sub run {
    # 等待登录界面或已进入桌面（最多 90 秒）
    assert_screen [ 'uos-login', 'uos-desktop' ], 90;

    # 若已在桌面，说明无需登录或已自动登录，本步骤通过
    if (match_has_tag('uos-desktop')) {
        return;
    }

    # 在登录界面：输入用户名（可按需从 get_var('USER_LOGIN') 或固定值读取）
    my $username = get_var('USER_LOGIN', 'uos');
    type_string $username;
    send_key 'tab';

    # 输入密码（通过 openQA 变量 USER_PASSWORD 传入，无密码时留空则仅回车）
    my $password = get_var('USER_PASSWORD', '');
    type_string $password if $password;
    send_key 'ret';

    # 等待登录完成后进入桌面（最多 120 秒）
    assert_screen 'uos-desktop', 120;
}

1;
