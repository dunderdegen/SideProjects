from pytube import YouTube
import customtkinter
from PIL import Image
import subprocess
from pathlib import Path
import os
downloads_path = str(Path.home() / "Downloads")

taskbar_logo_path = 'images/play.ico'
taskbar_title = "Youtube Loader GUI"
url= "C:\temp"




class MyTabMenu(customtkinter.CTkTabview):
    def __init__(self, master, **kwargs):
        super().__init__(master, **kwargs)

        self.add("Main")
        self.add("Other")

        # Main page

        self.logo_image = customtkinter.CTkImage(light_image=Image.open('images\play.png'),
                                                 dark_image=Image.open('images\play.png'),
                                                 size=(200,200))
        
        self.logo_image = customtkinter.CTkLabel(master=self.tab("Main"), image=self.logo_image,
                                                 text="")
        self.logo_image.pack(anchor="center", pady=100)

        self.url_bar = customtkinter.CTkEntry(master=self.tab("Main"),
                                              placeholder_text="Paste URL"
                                              )
        self.url_bar._set_appearance_mode("light")
        self.url_bar.pack(anchor="center", pady=10)

        self.loading_bar = customtkinter.CTkProgressBar(master=self.tab("Main"),
                                                        orientation="horizontal",
                                                        width=100,
                                                        indeterminate_speed=15,
                                                        mode="indeterminate")


        def download_video():
            print(self.url_bar.get())
            youtube_video = YouTube(self.url_bar.get())
            # youtube_video_name = youtube_video.title
            self.loading_bar.pack(anchor="n", pady=10, padx=10)
            self.loading_bar.start
                
            

            YouTube(self.url_bar.get()).streams.get_highest_resolution().download(downloads_path)

        self.download_button = customtkinter.CTkButton(master=self.tab("Main"),
                                                       text="Download",
                                                       command=download_video)
        self.download_button._set_appearance_mode("light")
        self.download_button.pack(anchor="center")

        # Other page

        self.label_other = customtkinter.CTkLabel(master=self.tab("Other"),
                                                  text="Thank you for testing my first finished project!",
                                                  font=("helvetica", 16),
                                                  text_color="black")
        self.label_other.pack(anchor="center", pady=30, padx=30)
        self.label_other1 = customtkinter.CTkLabel(master=self.tab("Other"),
                                                   text="Big thanks to Prinda985 for creating the logo \n and posting it to https://freepik.com",
                                                   font=("helvetica", 14),
                                                   text_color="black")
        self.label_other1.pack(anchor="center", pady=30, padx=30)



                                                       
        

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()

        # Window configuration
        self.title(taskbar_title)
        self.geometry(f"{600}x{600}")
        self.iconbitmap(taskbar_logo_path)
        self._set_appearance_mode("light")
        self.resizable(width=False, height=False)

        self.tab_view = MyTabMenu(master=self,
                                  width=580,
                                  height=580)
        self.tab_view._set_appearance_mode("light")
        self.tab_view.pack(anchor="center", padx=20, pady=20)



        

        






if __name__ == "__main__":
    app = App()
    app.mainloop()


# tribute : <a href="https://www.freepik.com/search">Icon by prinda895</a>