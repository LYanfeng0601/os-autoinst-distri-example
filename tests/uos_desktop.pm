# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
#
# UOS 桌面验证步骤：确认系统已进入图形桌面，可扩展为检查任务栏、图标等。
# 需配合 needle：uos-desktop 或 desktop。

use Mojo::Base 'basetest';
use testapi;

sub run {
    # 等待桌面出现（支持 uos-desktop 与 desktop 两种 tag，最多 60 秒）
    assert_screen [ 'uos-desktop', 'desktop' ], 60;

    # 可选：按需增加更多桌面元素检查，例如任务栏、开始菜单等
    # assert_screen 'uos-taskbar', 5;
}

1;
