data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "dynamodb_lambda" {
  name        = "dynamodb_lambda"
  description = "Policy for lambda to have dynamodb access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:UpadteItem",
          "dynamodb:Query",
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_lambda_policy" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_lambda.arn
}

resource "aws_lambda_function" "lambda" {
  filename      = "./lambda-functions/counter.zip" 
  function_name = "lambda_counter" 
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_counter.handler"

  runtime = "python3.8"

}
