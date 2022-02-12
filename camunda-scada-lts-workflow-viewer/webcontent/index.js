let currentWorkflowXML = "";
const pageElements = {};

function populatePageElements() {
  // List of elements to look for
  const seekedElements = [
    { id: 'workflow', name: 'select' },
    { id: 'bpmn-canvas', name: 'bpmnCanvas' }
  ];
  // Populate the state variable
  for (const element of seekedElements) {
    pageElements[element.name] = document.getElementById(element.id);
    if (!pageElements[element.name]) {
      console.error(`Element with id ${element.id} was not found!`);
    }
    console.debug("Loaded page element", element, pageElements[element.name]);
  }
  console.debug("Loaded page elements");
}

function drawBPMN() {
  if (currentWorkflowXML.length == 0) {
    console.debug("Skipping BPMN draw");
    return;
  }
  pageElements.bpmnCanvas.innerHTML = null;
  try {
    const bpmnViewer = new BpmnJS({
      container: '#bpmn-canvas'
    });
    bpmnViewer.importXML(currentWorkflowXML);
    
    const canvas = bpmnViewer.get('canvas');
    const overlays = bpmnViewer.get('overlays');

    canvas.zoom('fit-viewport');
  } catch (e) {
    console.error(e);
    alert(e);
  }
}

function setOptionWorkflowNames(workflowNames) {
  // Grab element
  const select = pageElements.select;
  // Helper to add an option
  function addOption(value, text, selected) {
    const newOption = document.createElement("option");
    newOption.value = value;
    newOption.text = text;
    newOption.selected = selected;
    select.options.add(newOption);
    console.debug("Added option", value, text, selected);
  }
  // Remove existing options
  for (const opt of select.options) {
    select.options.remove(opt);
    console.debug("Removed option", opt);
  }
  // Add default choice
  addOption(null, "Choose...", false);
  // Add choices
  for (const workflowName of workflowNames) {
    addOption(workflowName, workflowName, false);
  }
  // Enable the select
  if (select.disabled) {
    select.disabled = false;
    console.debug("Enabled select");
  }
}

async function loadAvailableWorkflows() {
  try {
    const workflowsResponse = await fetch('/workflows');
    if (!workflowsResponse.status == 200) {
      console.error(`wrong status for request ${workflowsResponse.status}`)
      alert(`wrong status for request ${workflowsResponse.status}`);
      return;
    }
    const workflowsXML = await workflowsResponse.text();
    const XMLParser = new DOMParser()
    const workflowsXMLDocument = XMLParser.parseFromString(workflowsXML, "text/xml");
    const root = workflowsXMLDocument.getRootNode();
    const workflows = Array.from(root.getElementsByTagName("workflows")[0].children);
    const workflowsNames = workflows.map(e => e.textContent);
    workflowsNames.sort();
    console.debug("Received workflow names", workflowsNames);
    setOptionWorkflowNames(workflowsNames);
  } catch (e) {
    console.error(e);
    alert(e);
  }
}

async function selectedWorkflowChanged() {
  // Grab element
  const select = pageElements.select;
  // Grab selection
  if (select.selectedOptions.length != 1) {
    console.debug("Ignoring a selection changed event", "Wrong number of selections");
  }
  const selectedOption = select.selectedOptions[0];
  const selectedOptionValue = selectedOption.value;
  if (selectedOptionValue == null || selectedOptionValue === 'null') {
    console.debug("Selection changed to no selection", "Skipping event");
    currentWorkflowXML = '';
    pageElements.bpmnCanvas.innerHTML = null;
    return;
  }
  console.debug("Selection changed to", selectedOptionValue);
  try {
    const workflowRequest = await fetch(`/workflows/${selectedOptionValue}`);
    if (workflowRequest.status != 200) {
      console.error(`wrong status for request ${workflowRequest.status}`)
      alert(`wrong status for request ${workflowRequest.status}`);
      return;
    }
    currentWorkflowXML = await workflowRequest.text();
    console.debug("New workflow XML length: ", currentWorkflowXML.length);
    drawBPMN();
  } catch (e) {
    console.error(e);
    alert(e);
  }
}

// On load
document.addEventListener('DOMContentLoaded', (event) => {
  // Set the pageElements state variable
  populatePageElements();
  // Load the available workflows
  loadAvailableWorkflows();
});