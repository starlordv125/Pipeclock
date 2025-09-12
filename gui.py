# Messing around with a gui for pipeclock, tkinter specifically
import os
import tkinter as tk
import tkinter.ttk as ttk
window = tk.Tk()
greeting = tk.Label(
    text='Hello, Tkinter',
    foreground='white',
    background='black'
)
greeting.pack()
window.mainloop()