FHIR_STORE?=store-1
DATASET?=dataset-1
BUCKET_PATH?=gs://tmcdev-fhir-imports
SUBDIR?=synthea_sample_data_fhir_r4_sep2019

.PHONY: import
import: 
	gcloud healthcare fhir-stores import gcs $(FHIR_STORE) --dataset=$(DATASET) --location=us-west1 --gcs-uri=$(BUCKET_PATH)/$(SUBDIR)/* --content-structure=bundle-pretty

.PHONY: make-bucket-public
make-bucket-public:
	gsutil iam ch allUsers:objectViewer $(BUCKET_PATH)
	# equivalent to:
	# gcloud storage buckets add-iam-policy-binding $(BUCKET_PATH) --member=allUsers --role=roles/storage.objectViewer

.PHONY: upload-testdata
upload-testdata: download-testdata
	gsutil -m cp fhir/* $(BUCKET_PATH)/$(SUBDIR)

.PHONY: download-testdata
download-testdata: synthea_sample_data_fhir_r4_sep2019.zip

synthea_sample_data_fhir_r4_sep2019.zip:
	wget https://synthetichealth.github.io/synthea-sample-data/downloads/synthea_sample_data_fhir_r4_sep2019.zip
	unzip synthea_sample_data_fhir_r4_sep2019.zip
