from PIL import Image
import numpy
import clipboard

imagePath = "PATH\\hd2.png"

image = Image.open(imagePath)
imageData = numpy.array(image.getdata()).reshape((image.height, image.width, 3))

# def compressImageData():
#     compressedImageData = imageData
#     rowIndex = 0
#     columnIndex = 0

#     for row in imageData:
#         rowIndex += 1
#         for pixel in row:
#             columnIndex += 1

#             row2Index = 0
#             column2Index = 0
#             for row2 in imageData:
#                 row2Index += 1
#                 for pixel2 in row2:
#                     column2Index += 1

#                     if pixel.all() == pixel2.all():
#                         print(str(row2Index) + "." + str(column2Index))
#                         compressedImageData[row2Index][column2Index] = str(row2Index) + "." + str(column2Index)
    
#     return compressedImageData
def rgb_to_hex(r, g, b):
    return ("{:X}{:X}{:X}").format(r, g, b)

def getHexedImageData():
    hexedImageData = imageData

    for rowIndex in imageData:
        for pixelIndex in rowIndex:
            
            hexedImageData[rowIndex][pixelIndex] = str(rgb_to_hex(pixel[0], pixel[1], pixel[2]))

# print(getHexedImageData())

# runInConsole = True

# clipboard.copy((runInConsole ? "_G.ImageData = " : "") + str(imageData.tolist()).replace("[", "{").replace("]", "}").replace(" ", ""))
clipboard.copy(str(imageData.tolist()).replace("[", "{").replace("]", "}").replace(" ", ""))
# {{{0, 1, 0}, {1, 3, 0}, {217, 140, 255}, {71, 24, 166}, {19, 0, 114}}}
