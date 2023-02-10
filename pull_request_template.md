<!--
Please fill in the appropriate checklist below (delete whatever is not relevant).
These are the most common things requested on pull requests (PRs).

Remember that PRs should be made against the master branch.
-->


### Description
The purpose of the code changes

### Preparations:

### How to test:
Run in a tmux screen or similar if testing on a large dataset.

### Expected outcome:
- [ ] Produced files contain expected values

### Review:
- [ ] Code reviewed by


## PR checklist

Closes #XXX <!-- If this PR fixes an issue, please link it here! -->

- [ ] This comment contains a description of changes (with reason).
- [ ] If you've fixed a bug or added code that should be tested, add tests!
- [ ] If necessary, include test data in your PR.
- [ ] Follow the input/output options guidelines.
- [ ] Add a resource `label`
- [ ] Use BioConda and BioContainers if possible to fulfil software requirements.
- Ensure that the test works with either Docker / Singularity. Conda CI tests can be quite flaky:
  - [ ] `PROFILE=docker pytest --tag <MODULE> --symlink --keep-workflow-wd --git-aware`
  - [ ] `PROFILE=singularity pytest --tag <MODULE> --symlink --keep-workflow-wd --git-aware`
  - [ ] `PROFILE=conda pytest --tag <MODULE> --symlink --keep-workflow-wd --git-aware`
