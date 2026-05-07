# **Simple Staph Genomics Analysis Toolkit**

This repository contains a collection of Bash scripts and environment configurations for the automated processing of multiple samlpe batches,  *Staphylococcus aureus*, and a simple pipeline for Next-Generation Sequencing (NGS) data.

This toolkit provides a streamlined, reproducible workflow for pathogen surveillance. It handles raw sequence data cleaning, alignment to a reference genome, and generation of alignment statistics.

These scripts are a loose predecessor of the  pipeline avaiable in the "Nextflow-Staph-V1" repo. 

### **| File | Description |**

| 'simple_pipeline_for_allV3.sh | Similar code as V2 can now be used for batch processing, as well as complete automation. |

| `simple_pipeline_for_allV2.sh` |  Features environment guards, error handling (`set -e`), and automated BWA indexing. |

| `staph_env.yml` | **Conda Environment Specification.** Contains all software dependencies and versioning. |

| `simple_pipeline_for_all.sh` | Initial functional draft of the mapping general pipeline. |

| `Simple_pipeline_SRR37176627` | Where the project started. |

### **Setup & Requirements**

1. Recreate the Environment
Instead of manual installations, you can recreate the exact analysis environment used for this project:
```bash
conda env create -f staph_env.yml
conda activate staph_env
