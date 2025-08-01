import matplotlib.pyplot as plt
import networkx as nx
import numpy as np

fig, ax = plt.subplots()
fig.canvas.manager.set_window_title('Normalizing Graph')

G = nx.Graph()

G.add_nodes_from([1,42])

G.add_edge(1,2, minlen = 2)
G.add_edge(2,1, minlen = 2)
G.add_edge(1,3, minlen = 2)
G.add_edge(3,1, minlen = 2)
G.add_edge(4,2, minlen = 2)
G.add_edge(2,4, minlen = 2)
G.add_edge(4,5, minlen = 2)
G.add_edge(5,4, minlen = 2)
G.add_edge(6,2, minlen = 2)
G.add_edge(2,6, minlen = 2)
G.add_edge(6,7, minlen = 2)
G.add_edge(7,6, minlen = 2)
G.add_edge(8,2, minlen = 2)
G.add_edge(2,8, minlen = 2)
G.add_edge(8,9, minlen = 2)
G.add_edge(9,8, minlen = 2)
G.add_edge(10,11, minlen = 2)
G.add_edge(11,10, minlen = 2)
G.add_edge(10,12, minlen = 2)
G.add_edge(12,10, minlen = 2)
G.add_edge(10,13, minlen = 2)
G.add_edge(13,10, minlen = 2)
G.add_edge(10,14, minlen = 2)
G.add_edge(14,10, minlen = 2)
G.add_edge(10,15, minlen = 2)
G.add_edge(15,10, minlen = 2)
G.add_edge(16,11, minlen = 2)
G.add_edge(11,16, minlen = 2)
G.add_edge(16,17, minlen = 2)
G.add_edge(17,16, minlen = 2)
G.add_edge(16,18, minlen = 2)
G.add_edge(18,16, minlen = 2)
G.add_edge(16,19, minlen = 2)
G.add_edge(19,16, minlen = 2)
G.add_edge(16,20, minlen = 2)
G.add_edge(20,16, minlen = 2)
G.add_edge(21,11, minlen = 2)
G.add_edge(11,21, minlen = 2)
G.add_edge(21,22, minlen = 2)
G.add_edge(22,21, minlen = 2)
G.add_edge(21,23, minlen = 2)
G.add_edge(23,21, minlen = 2)
G.add_edge(21,24, minlen = 2)
G.add_edge(24,21, minlen = 2)
G.add_edge(21,25, minlen = 2)
G.add_edge(25,21, minlen = 2)
G.add_edge(26,11, minlen = 2)
G.add_edge(11,26, minlen = 2)
G.add_edge(26,27, minlen = 2)
G.add_edge(27,26, minlen = 2)
G.add_edge(26,28, minlen = 2)
G.add_edge(28,26, minlen = 2)
G.add_edge(26,29, minlen = 2)
G.add_edge(29,26, minlen = 2)
G.add_edge(26,30, minlen = 2)
G.add_edge(30,26, minlen = 2)
G.add_edge(2,3, minlen = 2)
G.add_edge(3,2, minlen = 2)
G.add_edge(2,5, minlen = 2)
G.add_edge(5,2, minlen = 2)
G.add_edge(2,7, minlen = 2)
G.add_edge(7,2, minlen = 2)
G.add_edge(2,9, minlen = 2)
G.add_edge(9,2, minlen = 2)
G.add_edge(2,11, minlen = 2)
G.add_edge(11,2, minlen = 2)
G.add_edge(3,31, minlen = 2)
G.add_edge(31,3, minlen = 2)
G.add_edge(3,32, minlen = 2)
G.add_edge(32,3, minlen = 2)
G.add_edge(3,33, minlen = 2)
G.add_edge(33,3, minlen = 2)
G.add_edge(5,34, minlen = 2)
G.add_edge(34,5, minlen = 2)
G.add_edge(5,35, minlen = 2)
G.add_edge(35,5, minlen = 2)
G.add_edge(5,36, minlen = 2)
G.add_edge(36,5, minlen = 2)
G.add_edge(7,37, minlen = 2)
G.add_edge(37,7, minlen = 2)
G.add_edge(7,38, minlen = 2)
G.add_edge(38,7, minlen = 2)
G.add_edge(7,39, minlen = 2)
G.add_edge(39,7, minlen = 2)
G.add_edge(9,40, minlen = 2)
G.add_edge(40,9, minlen = 2)
G.add_edge(9,41, minlen = 2)
G.add_edge(41,9, minlen = 2)
G.add_edge(9,42, minlen = 2)
G.add_edge(42,9, minlen = 2)
G.add_edge(11,15, minlen = 2)
G.add_edge(15,11, minlen = 2)
G.add_edge(11,20, minlen = 2)
G.add_edge(20,11, minlen = 2)
G.add_edge(11,25, minlen = 2)
G.add_edge(25,11, minlen = 2)
G.add_edge(11,30, minlen = 2)
G.add_edge(30,11, minlen = 2)


color_map = []

color_map.append('#%02x%02x%02x' % (101,37,223)) # 1
color_map.append('#%02x%02x%02x' % (101,37,223)) # 2
color_map.append('#%02x%02x%02x' % (181,156,228)) # 3
color_map.append('#%02x%02x%02x' % (101,37,223)) # 4
color_map.append('#%02x%02x%02x' % (181,156,228)) # 5
color_map.append('#%02x%02x%02x' % (101,37,223)) # 6
color_map.append('#%02x%02x%02x' % (181,156,228)) # 7
color_map.append('#%02x%02x%02x' % (101,37,223)) # 8
color_map.append('#%02x%02x%02x' % (181,156,228)) # 9
color_map.append('#%02x%02x%02x' % (181,156,228)) # 10
color_map.append('#%02x%02x%02x' % (101,37,223)) # 11
color_map.append('#%02x%02x%02x' % (103,102,177)) # 12
color_map.append('#%02x%02x%02x' % (103,102,177)) # 13
color_map.append('#%02x%02x%02x' % (103,102,177)) # 14
color_map.append('#%02x%02x%02x' % (101,37,223)) # 15
color_map.append('#%02x%02x%02x' % (181,156,228)) # 16
color_map.append('#%02x%02x%02x' % (103,102,177)) # 17
color_map.append('#%02x%02x%02x' % (103,102,177)) # 18
color_map.append('#%02x%02x%02x' % (103,102,177)) # 19
color_map.append('#%02x%02x%02x' % (101,37,223)) # 20
color_map.append('#%02x%02x%02x' % (181,156,228)) # 21
color_map.append('#%02x%02x%02x' % (103,102,177)) # 22
color_map.append('#%02x%02x%02x' % (103,102,177)) # 23
color_map.append('#%02x%02x%02x' % (103,102,177)) # 24
color_map.append('#%02x%02x%02x' % (101,37,223)) # 25
color_map.append('#%02x%02x%02x' % (181,156,228)) # 26
color_map.append('#%02x%02x%02x' % (103,102,177)) # 27
color_map.append('#%02x%02x%02x' % (103,102,177)) # 28
color_map.append('#%02x%02x%02x' % (103,102,177)) # 29
color_map.append('#%02x%02x%02x' % (101,37,223)) # 30
color_map.append('#%02x%02x%02x' % (103,102,177)) # 31
color_map.append('#%02x%02x%02x' % (103,102,177)) # 32
color_map.append('#%02x%02x%02x' % (103,102,177)) # 33
color_map.append('#%02x%02x%02x' % (103,102,177)) # 34
color_map.append('#%02x%02x%02x' % (103,102,177)) # 35
color_map.append('#%02x%02x%02x' % (103,102,177)) # 36
color_map.append('#%02x%02x%02x' % (103,102,177)) # 37
color_map.append('#%02x%02x%02x' % (103,102,177)) # 38
color_map.append('#%02x%02x%02x' % (103,102,177)) # 39
color_map.append('#%02x%02x%02x' % (103,102,177)) # 40
color_map.append('#%02x%02x%02x' % (103,102,177)) # 41
color_map.append('#%02x%02x%02x' % (103,102,177)) # 42

color_map[0], color_map[41] = color_map[41], color_map[0]
color_map = np.roll(color_map,1)

plt.title(r'Normalizing Graph')

pos = nx.spring_layout(G)
nx.draw(G,
 with_labels = True,
 font_color = 'white',
 font_size =  10,
 font_weight = 'bold',
 node_size = 200,
 node_color = color_map)
plt.show()