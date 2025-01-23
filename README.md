# project Jenkins

![Screenshot 2025-01-23 170040](https://github.com/user-attachments/assets/4371a47e-5ade-42bc-89ff-be1c96ed9b10)
![Screenshot 2025-01-23 170051](https://github.com/user-attachments/assets/52930a3a-1852-43ad-a056-5df6950ef7d2)
![Screenshot 2025-01-23 170101](https://github.com/user-attachments/assets/5f16221e-2960-4523-a50d-d42b70f36b35)
![Screenshot 2025-01-23 170136](https://github.com/user-attachments/assets/c57c25ec-2bd1-4cfe-9629-482ee8d10d8d)






## admin login

- username: admin
- password: admin

### install docker-compose

 ### To execute 
 ```bash
docker-compose up -d --build
```

### To delete
```bash
docker-compose down
```
 
### install mysql on amazonlinux 2

```bash
sudo yum update -y
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation 
sudo systemctl status mariadb
```
```bash
# Update the MySQL configuration file to allow remote connections
vi /etc/my.cnf

# add these line to my.cnf
bind-address=0.0.0.0
```
```bash
# Restart MariaDB service to apply changes
sudo systemctl restart mariadb

echo "MySQL configuration updated to allow remote connections and MariaDB service restarted."
```
---
### to give Grant access
```bash
mysql -u root -p
```
```bash
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '1234' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```
---
