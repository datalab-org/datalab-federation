# datalab-federation

A dashboard to show live datalab deployments and plugins (and maybe more in the future).
This repo would become the central point for datalab users, instead of the source code documentation.

## Potential planned features

- Stats dashboard
   - Mostly "marketing" or advertising for individual groups, but could foster collaborations in the future
-  Link resolver
   - i.e., datalab-org.science/ref/exmpl:AABBCC would look up the current URL for the `exmpl` provider, and redirect the client to the correct one.
   - This would also allow for archival functionality; a datalab could request to be scraped by the federation for public data, with all `exmpl`-prefixed refcodes being served statically from that point on (unless undone).
- OSS plugin registry
- Shared infrastructure:
   - pooled resources for offsite backups,
   - shared MongoDB replica sets with oplog enabled
