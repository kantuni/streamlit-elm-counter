import streamlit as st
import streamlit.components.v1 as components

counter = components.declare_component(
    "counter",
    # Development:
    # url="http://localhost:3000/",
    # Production:
    path="frontend/build/",
)

count = counter(key="count", default=0)
st.markdown(f"The value of the counter is **{count}**.")
