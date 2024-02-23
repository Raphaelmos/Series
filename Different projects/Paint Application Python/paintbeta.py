# Thinking of putting the French in English or maybe two files seperating it or a option to change language
from tkinter import *
from tkinter.messagebox import *
from tkinter import ttk
class Paint(Frame):
    def __init__(self, parent):
        Frame.__init__(self, parent)
        self.parent = parent
        self.brush_size = 5
        self.brush_color = "red"
        self.color = "red"
        self.setUI()

    def draw(self, event):
        self.canv.create_oval(event.x - self.brush_size,
                              event.y - self.brush_size,
                              event.x + self.brush_size,
                              event.y + self.brush_size,
                              fill=self.color, outline=self.color)

    def set_color(self, new_color):
        self.color = new_color



    def set_brush_size(self, new_size):
        self.brush_size = new_size

    def setUI(self):
        self.parent.title("Projet Python Beta MDLP")
        self.pack(fill=BOTH, expand=1)

        self.columnconfigure(6, weight=1)
        self.rowconfigure(2, weight=1)

        self.canv = Canvas(self, bg="white")

        self.canv.grid(row=2, column=0, columnspan=7, padx=5, pady=5, sticky=E + W + S + N)

        self.canv.bind("<B1-Motion>", self.draw)
        color_lab = Label(self, text="Paramètres")

        color_lab.grid(row=0, column=0, padx=6)

        red_btn = Button(self, text="rouge", width=10, command=lambda: self.set_color("red"))

        red_btn.grid(row=0, column=1)

        green_btn = Button(self, text="Vert", width=10, command=lambda: self.set_color("green"))
        green_btn.grid(row=0, column=2)

        blue_btn = Button(self, text="Bleu", width=10, command=lambda: self.set_color("blue"))
        blue_btn.grid(row=0, column=3)

        black_btn = Button(self, text="Noir", width=10, command=lambda: self.set_color("black"))
        black_btn.grid(row=0, column=4)

        white_btn = Button(self, text="Blanc", width=10, command=lambda: self.set_color("white"))
        white_btn.grid(row=0, column=5)

        size_lab = Label(self, text="Grosseur du pinceau: ")
        size_lab.grid(row=1, column=0, padx=5)
        one_btn = Button(self, text="2x", width=10, command=lambda: self.set_brush_size(2))
        one_btn.grid(row=1, column=1)

        two_btn = Button(self, text="5x", width=10, command=lambda: self.set_brush_size(5))
        two_btn.grid(row=1, column=2)

        five_btn = Button(self, text="7x", width=10, command=lambda: self.set_brush_size(7))
        five_btn.grid(row=1, column=3)

        seven_btn = Button(self, text="10x", width=10, command=lambda: self.set_brush_size(10))
        seven_btn.grid(row=1, column=4)

        ten_btn = Button(self, text="20x", width=10, command=lambda: self.set_brush_size(20))
        ten_btn.grid(row=1, column=5)

        twenty_btn = Button(self, text="50x", width=10, command=lambda: self.set_brush_size(50))
        twenty_btn.grid(row=1, column=6, sticky=W)

        clear_btn = Button(self, text="Supprimer", width=10, command=lambda: self.canv.delete("all"))
        clear_btn.grid(row=0, column=6, sticky=W)


def main():
    global root
    root = Tk()
    root.geometry("800x600+300+300")
    # A good option to do would be to as will change the size of canvas
    app = Paint(root)
    m = Menu(root)
    root.config(menu=m)

    fm = Menu(m)
    root.mainloop()
if __name__ == "__main__":
    main()
