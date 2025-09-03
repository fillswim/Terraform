
```bash
ssh-keygen -f '/home/fill/.ssh/known_hosts' -R '192.168.2.121'
```

```bash
scp root@192.168.2.121:/root/.kube/config .kube/config
```