# AidMitra Student Planner — Supabase-configured build

This build has AidMitra's existing Supabase project URL and **publishable** client key preconfigured, so students do not need to enter Supabase credentials themselves.

## Publish to the existing GitHub Pages repository

1. Extract this ZIP.
2. Open your repository: https://github.com/aidmitra/aidmitra-student-planner
3. Choose **Add file → Upload files**.
4. Upload the six files from this folder to the repository root, replacing files with the same names.
5. Commit the changes to `main`.
6. Wait for GitHub Pages to redeploy, then refresh https://aidmitra.github.io/aidmitra-student-planner/ . If the old version remains, hard-refresh or clear the site cache.

## Supabase checklist

- The app uses the configured project URL and public publishable key in client-side code. Publishable keys are designed to be public; never use a `service_role` or secret key in the website.
- Ensure `supabase_schema.sql` has been run in the existing project's SQL Editor.
- In Supabase Authentication settings, set the Site URL to `https://aidmitra.github.io` and add `https://aidmitra.github.io/aidmitra-student-planner/**` (or the exact callback URLs required by the project's auth configuration) to allowed redirect URLs.
- Test signup and sign-in. If email confirmation is enabled, confirm the message before signing in.
- Test with two separate student accounts and verify Row Level Security prevents users from reading or changing each other's planner data.

## Important

This change preconfigures the client connection; it does not itself verify that the live Supabase database schema, authentication settings, or row-level security are correct. Keep the public repository limited to client-side publishable credentials. Do not upload database passwords, access tokens, or secret/service-role keys.
