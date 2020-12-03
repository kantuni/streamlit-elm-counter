import streamlit as st
import streamlit.components.v1 as components

counter = components.declare_component(
    "counter",
    # For development use:
    # url="http://localhost:3000/",
    # For production use:
    path="frontend/build/",
)

count = counter(key="count", initial=5, default=5)
st.markdown(f"The value of the counter is **{count}**.")
