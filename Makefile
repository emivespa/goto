# .env: https://www.robg3d.com/2020/05/2288/
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

.PHONY: deploy
deploy:
	sam deploy \
		--template-file template.yaml \
		--stack-name $$STACK_NAME \
		--capabilities CAPABILITY_IAM \
		--s3-bucket $$BUCKET_NAME \
		--parameter-overrides BucketName=$$BUCKET_NAME LinksFileKey=$$LINKS_FILE_KEY

.PHONY: local
local:
	sam local start-api \
	--parameter-overrides BucketName=$$BUCKET_NAME LinksFileKey=$$LINKS_FILE_KEY
