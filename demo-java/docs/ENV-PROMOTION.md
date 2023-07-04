# GitOps directory

## Application Environment Configuration

1. **Application Version** image tag in manifests

    Examples:

    - values-versions.yaml

2. **Kubernetes Specific Settings** eg. `replica`, `resourceLimit`, `healthCheck`, `persistentVolume`

    Example:

    - values-k8s-settings.yaml (static on environment. **DO NOT PROMOTE**)

3. **Static Application Setting**  Unrelated to K8S.

    Eg. External URL, Authentication profile.

    Example:

    - values-default.yaml

4. **Non-static Application Setting** Setting can be promoted to each enviroments

    This setting must be in `envs` levels

---

## Values precedances

Higher values will be overwrite lower.

1. **`common`** Shared values files for all environments
2. **`variants`** Variant specific values
3. **`envs`** Environment specific values

---

## Examples generate template for each environment

**DEV**:

- variant `non-prod`

```sh
 helm -n vote-dev upgrade vote . \
  -f values/common/values-common.yaml \
  -f values/variants/non-prod/values.yaml \
  -f values/envs/dev/values-env-settings.yaml \
  -f values/envs/dev/values-k8s-settings.yaml \
  -f values/envs/dev/values-app-settings.yaml \
  -f values/envs/dev/values-app-versions.yaml \
  --install --dry-run
```

**QA**:

- variant `non-prod`

```sh
 helm -n vote-qa upgrade vote . \
  -f values/common/values-common.yaml \
  -f values/variants/non-prod/values.yaml \
  -f values/envs/qa/values-env-settings.yaml \
  -f values/envs/qa/values-k8s-settings.yaml \
  -f values/envs/qa/values-app-settings.yaml \
  -f values/envs/qa/values-app-versions.yaml \
  --install --dry-run
```

**Staging-TH**:

- variants `prod`, `th`

```sh
 helm -n vote-staging-th upgrade vote . \
  -f values/common/values-common.yaml \
  -f values/variants/prod/values.yaml \
  -f values/variants/th/values.yaml \
  -f values/envs/staging-th/values-env-settings.yaml \
  -f values/envs/staging-th/values-k8s-settings.yaml \
  -f values/envs/staging-th/values-app-settings.yaml \
  -f values/envs/staging-th/values-app-versions.yaml \
  --install --dry-run
```

**Staging-US**:

- variants `prod`, `us`

```sh
 helm -n vote-staging-us upgrade vote . \
  -f values/common/values-common.yaml \
  -f values/variants/prod/values.yaml \
  -f values/variants/us/values.yaml \
  -f values/envs/staging-us/values-env-settings.yaml \
  -f values/envs/staging-us/values-k8s-settings.yaml \
  -f values/envs/staging-us/values-app-settings.yaml \
  -f values/envs/staging-us/values-app-versions.yaml \
  --install --dry-run
```

**Production-TH**:

- variants `prod`, `th`

```sh
 helm -n vote-prod-th upgrade vote . \
  -f values/common/values-common.yaml \
  -f values/variants/prod/values.yaml \
  -f values/variants/th/values.yaml \
  -f values/envs/prod-th/values-env-settings.yaml \
  -f values/envs/prod-th/values-k8s-settings.yaml \
  -f values/envs/prod-th/values-app-settings.yaml \
  -f values/envs/prod-th/values-app-versions.yaml \
  --install --dry-run
```

**Production-US**:

- variants `prod`, `us`

```sh
 helm -n vote-prod-us upgrade vote . \
  -f values/common/values-common.yaml \
  -f values/variants/prod/values.yaml \
  -f values/variants/us/values.yaml \
  -f values/envs/prod-us/values-env-settings.yaml \
  -f values/envs/prod-us/values-k8s-settings.yaml \
  -f values/envs/prod-us/values-app-settings.yaml \
  -f values/envs/prod-us/values-app-versions.yaml \
  --install --dry-run
```

---

## Promote scenarios

1. Promote **qa** to **staging-th**.

    ```sh
    cp values/envs/qa/values-app-* values/envs/staging-th/
    ```

2. PRomote **staging-th** to **prod-th**.

    ```sh
    cp values/envs/qa/values-app-* values/envs/staging-th/
    ```

---
