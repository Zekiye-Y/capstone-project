<a name="readme-top"></a>



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Zekiye-Y/capstone-project">
    <img src="images/imra.jpeg" alt="Logo" width="300" height="150">
  </a>

<h1 align="center">IMRA Auto segmentation Application</h1>

</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributors">Contributors</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

[![Application screenshot][application-screenshot]](https://github.com/Zekiye-Y/capstone-project)

The IMRA auto segmentation Application serves as a practical tool for medical imaging, 
particularly in the domain of kidney classification with DICOM data. 
By allowing users to upload CT scans and choose a classification complexity, 
it offers a more streamlined approach compared to manual labeling methods. 
While the application primarily aids in simplifying IMRA's workflow, 
its design keeps future organ expansions in consideration. 
The application seeks to provide a balanced blend of usability and precision in diagnostic preparations.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Built With

* [![R][R-project.org]][R-url]
* [![Python][python.org]][Python-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started

How to set up application locally and run it.

### Prerequisites

The thing you need to run the application and how to install them.
* eg. python, R shiny
  ```sh
  brew install python3
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Zekiye-Y/capstone-project.git
   ```
2. Install python ml packages eg. keras, tensorflow etc
   ```sh
   pip3 install keras
   ```


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Here's a quick guide to get you started:

1. **Uploading DICOM Data**:
    - Launch the application.
    - Navigate to the 'Upload' section.
    - Select or drag-and-drop the patient's CT scan in DICOM format.

2. **Selecting Classification Complexity**:
    - Once your CT scan is uploaded, navigate to the 'Classification' section.
    - Choose the desired classification complexity. 

3. **Reviewing Results**:
    - After making your selection, the application will process and classify the scan.
    - View the segmented and classified DICOM data within the 'Results' section.
    - Here, layers are labeled based on content, e.g., kidney, tumor, etc.

4. **Additional Features** :
    - The 'Results' section also allows users to view the original DICOM data.
    - Users can also view the classification accuracy and loss graphs.

5. **Exporting Data**:
    - Once satisfied with the classification, navigate to the 'Export' section.
    - Download the classified segmented file for further use or analysis.

[![Application screenshot][application-screenshot]](https://github.com/Zekiye-Y/capstone-project)
*Interface of the IMRA Auto segmentation Application showcasing a kidney classification.*

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTORS -->
## Contributors

* Aleisha Dillon: email@email.com
* Ei Thiri Lwin: email@email.com
* Frederick Amad: email@email.com
* Mario Kweku Djameh: email@email.com
* Zekiye Yildirim: email@email.com

Project Link: [https://github.com/Zekiye-Y/capstone-project](https://github.com/Zekiye-Y/capstone-project)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Resources that helped us to build this project:

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[application-screenshot]: images/application.png
[python.org]: https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54
[Python-url]: https://www.python.org/
[R-project.org]: https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white
[R-url]: https://www.r-project.org/
