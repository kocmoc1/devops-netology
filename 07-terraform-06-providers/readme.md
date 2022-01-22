# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

## 1.1
https://github.com/hashicorp/terraform-provider-aws/blob/75d2acaeccae509d54496e079493d143f9c3658b/internal/provider/provider.go#L345

## 1.2.1
```buildoutcfg
		"name": {
			Type:          schema.TypeString,
			Optional:      true,
			Computed:      true,
			ForceNew:      true,
			ConflictsWith: []string{"name_prefix"},
		},
		"name_prefix": {
			Type:          schema.TypeString,
			Optional:      true,
			Computed:      true,
			ForceNew:      true,
			ConflictsWith: []string{"name"},
```
## 1.2.2
80 символов

## 1.2.3

```buildoutcfg
		var re *regexp.Regexp

		if fifoQueue {
			re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,75}\.fifo$`)
		} else {
			re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,80}$`)
		}

		if !re.MatchString(name) {
			return fmt.Errorf("invalid queue name: %s", name)
		}

```
