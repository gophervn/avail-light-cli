## Avail Light Client

1. Run the follwing command:
```bash
curl -s https://raw.githubusercontent.com/techxnode/avail-light-cli/main/start.sh | bash
```
2. Check log:
```bash
journalctl -f -u availd
```
3. Check status:
```bash
systemctl status availd
```
