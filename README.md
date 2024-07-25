# ICE ERO-LESA enforcement data

This repository processes and analyzes U.S. Immigration and Customs Enforcement (ICE) data released pursuant to FOIA requests by the University of Washington Center for Human Rights.

The datasets analyzed here were released by ICE's Enforcement and Removal Operations (ERO) Law Enforcement Systems and Analysis Division (LESA); the datasets represent nationwide individual enforcement actions in three categories: encounters, arrests, and removals.

The most current datasets analyzed cover the period from October 1, 2011 through January 29, 2023, representing the full U.S. government Fiscal Years 2012-2022.

## FOIA Request

> We request records of all encounters, arrests, and removals nationwide from 10/1/2011 to date, from the ERO-LESA Statistical Tracking Unit in XLS, XLSX, or CSV spreadsheet format; including but not limited to the following fields and including any related definitions, legends, or codebooks: - Area of Responsibility - Arrest/Encounter/Removal Date - Arrest Method - Apprehension Landmark - Operation - Processing Disposition - Citizenship Country - Gender - Race/Ethnicity - Complexion - Removal Case COL (Threat Level) - Final Charge Section We are not providing third party consent forms for all those whose data would be included and therefore understand that as a result, personally-identifiable information will be redacted to protect their privacy. However, the FOIA requires that all segregable information be provided to requesters, and personally-identifiable information is segregable from the remainder of this information. We know that such information is available as an output from the ERO-LESA Statistical Tracking Unit because we requested and received it pursuant to 2019-ICFO-53623.

Original, untransformed datasets are located in `import/input/`; final datasets with minimal cleaning and standardization are located in `export/output/`.

# Repository requirements and structure 

This repository requires the use of [Git LFS](https://git-lfs.com/), it must be installed before cloning this repository.

This project uses "Principled Data Processing" techniques and tools developed by [@HRDAG](https://github.com/HRDAG); see for example ["The Task Is A Quantum of Workflow."](https://hrdag.org/2016/06/14/the-task-is-a-quantum-of-workflow/)

The repository is divided into separate tasks which follow a regular structure; task inputs and outputs are linked using symlinks.

- `import/` - Contains original un-transformed Excel files in `import/input/` and compressed, CSV-formatted files for each annual sheet in `import/frozen/`
- `concat/` - Concatenates annual data into combined datasets for each enforcement category, assigns sequential row `id` and `hashid`
- `clean/` - Performs minimal data cleaning to standardize AOR values; cleaning operations can be extended using `clean/hand/clean_rules.yaml`
- `export/` - Convenience task to generate final export versions of datasets in `export/output/`
- `analyze/` - Exploratory analysis of final datasets.
- `write/` - Generates data notebooks for publication.
- `docs/` - Data notebooks published to [https://uwchr.github.com/ice-enforce/]
