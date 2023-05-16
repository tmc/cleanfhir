FHIR_STORE?=store-1
DATASET?=dataset-1
BUCKET_PATH?=gs://tmcdev-fhir-imports

.PHONY: import
import: 
	gcloud healthcare fhir-stores import gcs $(FHIR_STORE) --dataset=$(DATASET) --location=us-west1 --gcs-uri=$(BUCKET_PATH)* --content-structure=bundle-pretty

.PHONY: make-bucket-public
make-bucket-public:
	gsutil iam ch allUsers:objectViewer $(BUCKET_PATH)
	# equivalent to:
	# gcloud storage buckets add-iam-policy-binding $(BUCKET_PATH) --member=allUsers --role=roles/storage.objectViewer
