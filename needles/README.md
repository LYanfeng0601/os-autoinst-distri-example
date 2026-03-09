# Needles 说明

本目录存放 openQA 针（needle）文件，每个针由同名的 `.json` 与 `.png` 组成。

## 已有针

| 文件名 | 用途 / tags |
|--------|--------------|
| uos-boot-menu | UOS 启动菜单 |
| bootloader | 引导界面 / 无启动介质 |
| kernel-panic | 内核恐慌（失败场景） |

## 新增针（需自行截取 PNG）

以下 JSON 已就绪，请在实际 UOS 环境中截取对应界面并保存为同名的 `.png`，或使用 openQA 的 needle 编辑器生成：

| 文件名 | 用途 |
|--------|------|
| **uos-login** | 登录界面（用户名/密码输入框） |
| **uos-desktop** | UOS 图形桌面 |
| **desktop** | 通用桌面（与 uos-desktop 二选一或共用） |

截取后请根据实际界面调整对应 JSON 中的 `area`（xpos, ypos, width, height）和 `match` 阈值。
