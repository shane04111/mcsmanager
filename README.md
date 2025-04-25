# mcsmanager
對mcsmanager linux的自動化腳本做了一些改良
包括:
- 自動抓取最新版本
- 只裝後臺

# 使用
- 純後臺: `sudo su -c "wget -qO- https://raw.githubusercontent.com/shane04111/mcsmanager/main/daemon/setup_cn.sh | bash"`
- 自動抓取最新版本安裝: `sudo su -c "wget -qO- https://raw.githubusercontent.com/shane04111/mcsmanager/main/both/setup_cn.sh | bash`
- 更新已安裝檔案: `sudo su -c "wget -qO- https://raw.githubusercontent.com/shane04111/mcsmanager/main/update/setup_cn.sh | bash`
