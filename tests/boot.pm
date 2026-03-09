# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later
# Adapted for UOS: match uos-boot-menu (success) or kernel-panic (failure)

use Mojo::Base 'basetest';
use testapi;

sub run {
    # Wait for one of: UOS boot menu (success), original bootloader, or kernel panic (failure)
    assert_screen [ 'uos-boot-menu', 'bootloader', 'kernel-panic' ], 120;

    # Fail immediately if kernel panic is detected
    if (match_has_tag('kernel-panic')) {
        die 'Kernel panic detected: No working init found. Boot failed.';
    }

    # Conclude test early if there's no boot media (original example tag)
    return undef if match_has_tag('no-boot-media');

    # Press enter to boot
    send_key 'ret';

    # UOS boot menu reached = success for this test; no need to wait for desktop/installer
    if (match_has_tag('uos-boot-menu')) {
        return;
    }

    # Original flow: wait for desktop (example distro)
    assert_screen 'desktop', 300;
}

1;
