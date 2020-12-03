import { RenderData, Streamlit } from "streamlit-component-lib"

declare global {
  interface Window {
    Elm: any
  }
}

// Initialize the Elm app.
const app = window.Elm.Main.init({
  node: document.getElementById("root"),
})

// Subscribe to messages from the Elm app.
app.ports.fromElm.subscribe((count: number) => {
  Streamlit.setComponentValue(count)
})

// Only set the default value if this variable is false.
// Otherwise, the counter will reset to the default value after every render.
let defaultValueHasBeenSet = false

/**
 * The component's render function. This will be called immediately after
 * the component is initially loaded, and then again every time the
 * component gets new data from Python.
 */
function onRender(event: Event): void {
  // Get the RenderData args from the event.
  const { args } = (event as CustomEvent<RenderData>).detail

  // If the default value is provided, set the component value to it.
  if (args.default !== null && !defaultValueHasBeenSet) {
    app.ports.fromJS.send(args.default)
    Streamlit.setComponentValue(args.default)
    defaultValueHasBeenSet = true
  }
}

// Attach our `onRender` handler to Streamlit's render event.
Streamlit.events.addEventListener(Streamlit.RENDER_EVENT, onRender)

// Tell Streamlit we're ready to start receiving data. We won't get our
// first RENDER_EVENT until we call this function.
Streamlit.setComponentReady()

// Finally, tell Streamlit to update our initial height. We omit the
// `height` parameter here to have it default to our scrollHeight.
Streamlit.setFrameHeight()
