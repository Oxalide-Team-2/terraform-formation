# Projet 1

L'objectif de cet exercice est de prendre en main les commandes cli de base de Terraform et de faire un tour d'horizon du provider AWS, des interpolations et des modules.

## Question 1:

#### Terraform [init](https://www.terraform.io/docs/commands/init.html)

Terraform init permet d'initialiser une configuration terraform. Cette commande
est idempotente, vous pouvez donc l'utilisez plusieurs fois dans un projet sans
crainte.

Cette commande permet de configurer les backends, de récupérer le remote state,
et de télécharger les modules.

```
cd projet_1/terraform
terraform init github.com/Oxalide-Team-2/terraform-provider-aws/examples/networking

terraform plan
# what happen ?
```
## Question 2:

Toujours dans le projet_1
```
cd projet_1/terraform
```

Executez:
```
terraform plan
```

Pourquoi une erreur mentionnant base_cidr_block survient-elle ?

/!\ Ne faites pas de apply /!\

### Question 3:

Calculer les subnets que va créer cette interpolation pour eu-west-1 :

```
cidr_block = "${cidrsubnet(var.base_cidr_block, 4, lookup(var.region_numbers, var.region))}"
```

## Un point sur les modules:

Les modules terraform sont un moyen de factoriser du code HCL.

Ils peuvent être appelés plusieurs fois dans un même projet afin de créer des ressources différentes.

Terraform ne lit que les fichier .tf à la racine du dossier dans lequel il est executé. Les modules peuvent donc se trouver dans des dossiers à la racine du projet.

On appelle le module grâce paramètre source.
```
module "consul" {
  source = "./consul"
}
```
https://www.terraform.io/docs/modules/sources.html


Le layout le plus simple et communément rencontré est celui-ci:

```
monmodule
├── main.tf
├── outputs.tf
├── README.md
└── variables.tf
```

- Le fichier main.tf contient toutes les ressources à créer.
- Le fichier variables.tf contient les variables avec leur valeur défaut et les variables obligatoires.
- Le fichier outputs.tf contient toutes les sorties des ressources ou datasource utilisées dans le fichier main.tf.

Il n'est pas possible de récupérer les "Attributes Reference" des ressources créées dans un module depuis root. C'est le fichier output qui permet d'exposer ces données à la racine.

Comment appeler les "outputs" d'un module
`${module.NAME.ATTRIBUTE}`

## Question 4:

Allez dans:

```cd projet_1/terraform/subnet/subnet.tf```


Calculer les subnets que va créer cette interpolation pour eu-west-1c:
```
cidr_block = "${cidrsubnet(data.aws_vpc.target.cidr_block, 4, lookup(var.az_numbers, data.aws_availability_zone.target.name_suffix))}"
```
