import streamlit as st
import streamlit.components.v1 as components

counter_component = components.declare_component(
    "counter",
    # Production:
    path="frontend/build/",
    # Development:
    # url="http://localhost:3000/",
)

count = counter_component(key="count", default=0)
st.markdown(f"The value of the counter is **{count}**.")
