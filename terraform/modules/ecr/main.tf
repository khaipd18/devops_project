resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_repository_policy" "this" {
  count      = (length(var.allow_push_principals) + length(var.allow_pull_principals)) > 0 ? 1 : 0
  repository = aws_ecr_repository.ecr_repository.name
  policy     = data.aws_iam_policy_document.repository_policy.json
}

resource "aws_ecr_lifecycle_policy" "untagged_images_policy" {
  repository = aws_ecr_repository.ecr_repository.name
  policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 14 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 14
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "archived_images_policy" {
  repository = aws_ecr_repository.ecr_repository.name
  policy     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Archive images not pulled in 90 days",
      "selection": {
        "tagStatus": "any",
        "countType": "sinceImagePulled",
        "countUnit": "days",
        "countNumber": 90
      },
      "action": {
        "type": "transition",
        "targetStorageClass": "archive"
      }
    },
    {
      "rulePriority": 2,
      "description": "Delete images archived for more than 365 days",
      "selection": {
        "tagStatus": "any",
        "storageClass": "archive",
        "countType": "sinceImageTransitioned",
        "countUnit": "days",
        "countNumber": 365
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}