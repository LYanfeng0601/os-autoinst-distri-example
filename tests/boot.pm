# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
#
# 本测试适配 UOS：成功时匹配 uos-boot-menu，失败时匹配 kernel-panic。
# 用于验证系统从启动到出现 UOS 启动菜单（或原版引导/桌面）的引导流程。

use Mojo::Base 'basetest';    # 继承 os-autoinst 的 basetest 基类
use testapi;                  # 引入 testapi，提供 assert_screen、send_key 等测试接口

sub run {
    # -----------------------------------------------------------------------
    # 第一步：等待屏幕出现以下三种情况之一（最多等待 120 秒）
    #   - uos-boot-menu：UOS 启动菜单，表示引导成功
    #   - bootloader：原始引导界面（兼容原版示例流程）
    #   - kernel-panic：内核恐慌，表示引导失败
    # -----------------------------------------------------------------------
    assert_screen [ 'uos-boot-menu', 'bootloader', 'kernel-panic' ], 120;

    # 若检测到内核恐慌，立即终止测试并抛出异常，标记为失败
    if (match_has_tag('kernel-panic')) {
        die 'Kernel panic detected: No working init found. Boot failed.';
    }

    # 若匹配到“无启动介质”标签（原版示例中的情况），提前结束测试，返回 undef
    return undef if match_has_tag('no-boot-media');

    # 在当前界面按下回车键，继续启动流程（例如从启动菜单进入系统）
    send_key 'ret';

    # 若当前已是 UOS 启动菜单，说明本测试目标已达成，直接成功返回，无需再等桌面/安装程序
    if (match_has_tag('uos-boot-menu')) {
        return;
    }

    # 否则走原版示例流程：等待桌面出现（最多 300 秒），用于非 UOS 或兼容场景
    assert_screen 'desktop', 300;
}

# Perl 模块必须以真值结束
1;
