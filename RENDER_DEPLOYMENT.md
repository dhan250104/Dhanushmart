# DhanushMart — Render deployment

## 1. Push this folder to GitHub
Commit the source code, `Dockerfile`, `pom.xml`, and `database/dhanushmart.sql`. Do not commit `.env` files or API keys.

## 2. Create a Render Web Service
- In Render, choose **New + → Web Service** and select this GitHub repository.
- Runtime: **Docker**
- Dockerfile Path: `./Dockerfile`
- Branch: `main` (or the branch you use)
- Choose a plan available to your account.

## 3. Configure Environment Variables
Set these in the Render service's **Environment** page:
- `DB_URL`: JDBC URL for your external MySQL database, for example `jdbc:mysql://YOUR_HOST:3306/dhanushmart?sslMode=REQUIRED&serverTimezone=UTC` (use the SSL settings required by your provider).
- `DB_USERNAME`: database username
- `DB_PASSWORD`: database password
- `OPENAI_API_KEY`: optional; only if AI image search is used
- `OPENAI_MODEL`: optional; defaults to `gpt-4o-mini`

Render does not provide a managed MySQL database with its web service. Create/use a separate MySQL host and allow secure network access from the Render service.

## 4. Initialize the database
Create a database named `dhanushmart` on the MySQL provider. Import `database/dhanushmart.sql` with a MySQL client if you need the tables and sample data from that file. Do not expose the database publicly without appropriate access controls.

## 5. Deploy and verify
Click **Deploy** and inspect Render logs. Open the service's public URL after the application starts. If startup fails, verify the JDBC URL, username/password, SSL configuration, and network allow-list.

## Local development note
The deployment `application.properties` requires `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD`. Set these in your local terminal before running the app locally, or use a separate local-only Spring profile. Do not commit database credentials.
