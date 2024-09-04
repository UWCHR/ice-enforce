# ICE immigration enforcement data

This repository processes and analyzes U.S. Immigration and Customs Enforcement (ICE) data released pursuant to FOIA requests by the University of Washington Center for Human Rights.

The datasets analyzed here were released by ICE's Enforcement and Removal Operations (ERO) Law Enforcement Systems and Analysis Division (LESA) from ICE’s Integrated Decision Support (IIDS) database; the datasets represent nationwide individual enforcement actions in three categories: encounters, arrests, and removals.

The most current datasets analyzed cover the period from October 1, 2011 through January 29, 2023, representing the full U.S. government fiscal years 2012-2022.

An overview of the data in this repository can be found at: https://uwchr.github.com/ice-enforce/

## FOIA Request

> We request records of all encounters, arrests, and removals nationwide from 10/1/2011 to date, from the ERO-LESA Statistical Tracking Unit in XLS, XLSX, or CSV spreadsheet format; including but not limited to the following fields and including any related definitions, legends, or codebooks: - Area of Responsibility - Arrest/Encounter/Removal Date - Arrest Method - Apprehension Landmark - Operation - Processing Disposition - Citizenship Country - Gender - Race/Ethnicity - Complexion - Removal Case COL (Threat Level) - Final Charge Section We are not providing third party consent forms for all those whose data would be included and therefore understand that as a result, personally-identifiable information will be redacted to protect their privacy. However, the FOIA requires that all segregable information be provided to requesters, and personally-identifiable information is segregable from the remainder of this information. We know that such information is available as an output from the ERO-LESA Statistical Tracking Unit because we requested and received it pursuant to 2019-ICFO-53623.

# Repository description

## Data

Large data files are excluded from this repository; data associated with this repository can be obtained here: https://drive.google.com/drive/folders/1twzNrtb8eb-smcGCTZtkNdLtAHLoxmUg?usp=drive_link

To execute tasks in this repository, first download the data files linked above and ensure it is stored in the indicated directory within the Git respository: original, untransformed datasets are stored in `import/input/`; compressed, CSV-formatted files for each annual sheet are stored in `import/frozen/`.

Final datasets with minimal cleaning and standardization are generated in `export/output/`. Users interested in reviewing the final datasets without executing the code contained in this repository can find export datasets as of Sept. 4, 2024 at the following link: https://drive.google.com/drive/folders/1XHVIOld3HvPVHipP881GjMCiioYrbU2b?usp=drive_link

## Structure

This project uses "Principled Data Processing" techniques and tools developed by [@HRDAG](https://github.com/HRDAG); see for example ["The Task Is A Quantum of Workflow."](https://hrdag.org/2016/06/14/the-task-is-a-quantum-of-workflow/)

The repository is divided into separate tasks which follow a regular structure; tasks linked using symlinks.

- `import/` - Contains original un-transformed Excel files in `import/input/` and compressed, CSV-formatted files for each annual sheet in `import/frozen/`
- `concat/` - Concatenates annual data into combined datasets for each enforcement category, assigns sequential row `id` and `hashid`
- `clean/` - Performs minimal data cleaning to standardize AOR values; cleaning operations can be extended using `clean/hand/clean_rules.yaml`
- `export/` - Convenience task to generate final export versions of datasets in `export/output/`
- `write/` - Generates descriptive notebooks for publication.
- `docs/` - Descriptive notebooks published at: https://uwchr.github.com/ice-enforce/
