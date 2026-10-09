# DhanushMart — public deployment (Render + MySQL)

This project uses Java 17, Spring Boot 3.5, Maven, Thymeleaf and MySQL.

## Important
- This package prepares the app for deployment; it does not create a public URL automatically. You must deploy it from your own Render account.
- You must have a reachable MySQL server. Do not assume an internal hostname works outside the provider's private network.
- Never commit database passwords, API keys, or a populated `.env` file to GitHub.
- The existing `database/dhanushmart.sql` is a development/import script and contains `DROP TABLE IF EXISTS`. Run it only against a fresh, disposable database because it deletes existing tables before recreating them.

## Deploy using Render Blueprint
1. Extract this ZIP.
2. Push the contents of the `DhanushMart` folder (the folder containing `pom.xml`, `Dockerfile`, and `render.yaml`) to a GitHub repository.
3. Sign in to https://dashboard.render.com/.
4. Choose **New + → Blueprint** (or **New → Web Service** if Blueprint is not shown) and connect the repository.
5. If using Blueprint, Render reads `render.yaml` and asks you to enter `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD`.
6. Set the values from your MySQL provider, save, and let Render build/deploy.
7. After the service is live, open **Settings → Networking → Generate Domain** if a public domain has not been generated.

## Required Render environment variables
- `DB_URL`: JDBC URL, not a raw `mysql://` URL. Format: `jdbc:mysql://HOST:PORT/DATABASE_NAME`. Add provider-required TLS parameters if required.
- `DB_USERNAME`: MySQL username.
- `DB_PASSWORD`: MySQL password.
- `OPENAI_API_KEY`: optional; only needed for the AI image search feature.

The MySQL server must allow network connections from the deployed app. If the database has an internal/private URL, it will only work when the app runs on a network that can reach that hostname. Use the database provider's external connection endpoint if supported, and enable required TLS.

## Database setup
- For a new, empty database, import `database/dhanushmart.sql` only after reviewing it and confirming the selected database is disposable; it contains destructive `DROP TABLE` statements.
- If your database already contains data, do not run that script. Back up first and use a non-destructive migration instead.
- `spring.jpa.hibernate.ddl-auto=update` allows Hibernate to update entity tables, but it does not automatically insert the sample product data from the SQL script.

## Verify deployment
1. Open the generated `https://...onrender.com` domain.
2. If the deploy fails, open Render → service → **Logs** and look for the first `ERROR` or `Caused by` line.
3. `Driver ... claims to not accept jdbcUrl, ${DB_URL}` means `DB_URL` is missing or the value was entered incorrectly.
4. Connection refused / timeout usually means the hostname, port, firewall, or private-network route is wrong.
5. Access denied usually means the username/password or database privileges are wrong.

## Local run
Set `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD` in your terminal/environment, then run:

```bash
mvn clean spring-boot:run
```

Default local server port is 8080; on Render the Docker command uses Render's `PORT` value.
