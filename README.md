# <div align="center"><i>datalab</i> Federation</div>

<div align="center" style="padding-bottom: 5px">
<a href="https://demo.datalab-org.io"><img src="https://img.shields.io/badge/try_it_out!-public_demo_server-orange?logo=firefox"></a>
</div>

This repository contains an opt-in list of active *datalab* instances.
Registered your instance with this federation allows you to make use of certain shared features.

## Use cases

### Persistent link resolver for your *datalab* items (e.g., samples)

The service running at https://purl.datalab-org.io can be used to redirect any
requests for prefixed IDs to the correct registered *datalab* instance.
For example, a request for `purl.datalab-org.io/example:AABBCC` would be redirected to the correct URL for the `example` provider, if registered.

This service is intended to be used when creating QR codes or other labels with *datalab*, to avoid labels becoming obsolete if the instance URL or underlying API changes (due e.g., to a change in hosting).

These links can also be shared with selective permissions, to allow the holder to see e.g., safety information or compositions, without needing to log in.

Planned features:

- [ ] Streamlining the sharing of data between different *datalab* instances in the future,
- [ ] Enable archival of samples beyond the life of a *datalab* instance.
For example, if a group stops using *datalab*, any important information regarding their samples (composition, safety information) that should remain accessible to someone physically holding the sample need to can be preserved under the purl.datalab-org.io URL.

### Future use-cases

- Stats dashboard and monitoring
- OSS plugin registry
- Shared infrastructure:
   - pooled resources for offsite backups and data storage,
   - shared MongoDB replica sets with oplog enabled

## Registration process

To register your *datalab* instance with the federation, please open a pull request to this repository that does the following:

1) Choose a unique ID or `<prefix>` for your *datalab* instance. These should be short (though we can be somewhat flexible), containing lowercase letters and hyphens only.
1) Create a single YAML file under the `./src/instances` directory called
`./src/instances/<prefix>.yaml` with the following format.
1) Populate this file with the metadata of your instance, following the schema at `./schema.yaml`. You can use an existing instance (e.g., `demo.yaml`) as a template.
1) If you are familiar with the process, you can optionally validate this locally by installing the prerequisite
tools and running `make validate`, or building the Docker image from the
`./Dockerfile`.
1) Create your pull request to this repository with the new file; it will be
automatically validated by the GitHub Actions CI and then reviewed by an admin.

> [!CAUTION]
> Once accepted, your *datalab* instance URLs will be public, so ensure you have set up your account registration process to be as permissive/restrictive as you desire.
