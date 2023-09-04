import xml.etree.cElementTree as ET

def parseXML(file_name):
   # Parse XML with ElementTree
   tree = ET.ElementTree(file=file_name)
   root = tree.getroot()

   target = root.find('UserAssignments/TargetClockPeriod')

   performance = root.find('PerformanceEstimates')
   time = performance.find('SummaryOfTimingAnalysis/EstimatedClockPeriod')
   t_unit = performance.find('SummaryOfTimingAnalysis/unit').text
   latency = performance.find('SummaryOfOverallLatency/Best-caseLatency')
   if performance is None:
      print("performance not found")
   else:
      print("Latency (cycles) = %s" % (latency.text))
      print("Clock Period (%s) = %s" % (t_unit, time.text))
      print("Slack (%s) = %.3f" % (t_unit, float(target.text) - float(time.text)))
   
   area = root.find('AreaEstimates/Resources')
   if area is None:
      print("area not found")
   else:
      for resource in area:
         print("%s = %s" % (resource.tag, resource.text))


if __name__ == "__main__":
   import sys 
   # parseXML("float32/solution/syn/report/csynth.xml")
   parseXML(sys.argv[1])