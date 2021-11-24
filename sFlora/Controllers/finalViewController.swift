//
//  finalViewController.swift
//  sFlora
//
//  Created by Aditya Mittal on 8/12/21.
//

import UIKit
import Vision

class finalViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var plantDiseaseLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var finalView: UIView!
    
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var treatmentLabel: UILabel!
    
    @IBOutlet weak var learnMoreButton: UIButton!
    var confidecne = Int()
    
    var image = UIImage()
    var selectedPlant = String()
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = 20
        finalView.layer.cornerRadius = 20
        learnMoreButton.layer.cornerRadius = 10
        
        imageView.image = image
        print(selectedPlant)
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("Could Not Convert to CIIMage")
        }
        
        detect(image: ciImage)
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: pDiseaseClassifier().model) else {
            fatalError("Loading CoreML Model Failed")
        }
        
        let request = VNCoreMLRequest(model: model) { [self] (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to Proccess Image")
            }
            
            for x in results {
                if x.identifier.contains(self.selectedPlant) {
                    if x.confidence*100 > 5 {
                        
                        plantDiseaseLabel.text = (x.identifier)
                        
                        if x.identifier == "Apple - Black Rot" {
                            problemLabel.text = "Fungal infection from the fungus Botryosphaeria obtusa, causing black spots and rashes"
                            treatmentLabel.text = "Collect all diseased leaves and fruits away from plant - sanatize the tree with copper based sprays"
                            url = "https://www.gardeningknowhow.com/edible/fruits/apples/black-rot-on-apple-trees.htm"
                        } else if x.identifier == "Apple - Cedar Rust" {
                            problemLabel.text = "Variety of fungal infections restrinting plant's ability to gather sunlight and nutrients from the air"
                            treatmentLabel.text = "Collect all diseased leaves away from the plant, spray with pestisides - Sterol Inhibitors, or SI fungicides"
                            url = "https://gardenerspath.com/how-to/disease-and-pests/cedar-apple-rust-control/"
                        }
                        else if x.identifier == "Apple - Healthy" {
                            problemLabel.text = "No problem! Looking good!"
                            treatmentLabel.text = "None needed, though a nice pie wouldn't hurt!"
                            url = "https://www.tasteofhome.com/recipes/apple-pie/"
                        }
                        else if x.identifier == "Apple - Scab" {
                            problemLabel.text = "Fungal infection from the fungus Venturia inaequalis"
                            treatmentLabel.text = "Fungacides depending on type of apple plant, Clear area of all diseased plants, water well"
                            url = "https://extension.umn.edu/plant-diseases/apple-scab#fungicides-1165363"
                        }
                        else if x.identifier == "Bell Peper - Healthy" {
                            problemLabel.text = "No problem! Healthy Bell Pepper!"
                            treatmentLabel.text = "None needed, try serving as a pastry!"
                            url = "https://www.acouplecooks.com/favorite-bell-pepper-recipes/"
                        }
                        else if x.identifier == "Bell Peper - Backterial Spot" {
                            problemLabel.text = "Bacterial infection from Xanthomonas campestris pv. vesicatoria, creating large lesions, causing tissue to fall."
                            treatmentLabel.text = "Planting various plants resistant to the bacteria, purchase patogen-free seeds from local stores, make sure to collect all diseased plants"
                            url = "https://extension.wvu.edu/lawn-gardening-pests/plant-disease/fruit-vegetable-diseases/bacterial-leaf-spot-of-pepper"
                        }
                        else if x.identifier == "Blueberry - Healthy" {
                            problemLabel.text = "No problem! Healthy Blueberry!"
                            treatmentLabel.text = "None needed, but a nice pie won't hurt!"
                            url = "https://www.inspiredtaste.net/23159/homemade-blueberry-pie-recipe/"
                        }
                        else if x.identifier == "Cherry - Healthy" {
                            problemLabel.text = "No problem! Healthy Cherry!"
                            treatmentLabel.text = "None needed, try serving as a pie!"
                            url = "https://sallysbakingaddiction.com/cherry-pie/"
                        }
                        else if x.identifier == "Cherry - Powdery Mildew" {
                            problemLabel.text = "Biotrophic fungus Podosphaera clandestina, rendering cherries dangerous to consume"
                            treatmentLabel.text = "Research propper irrigation times, plant resistant plants"
                            url = "http://treefruit.wsu.edu/crop-protection/disease-management/cherry-powdery-mildew/"
                        }
                        else if x.identifier == "Corn - Common Rust" {
                            problemLabel.text = "Long periods of cool weather lead to rust colored spores"
                            treatmentLabel.text = "Plant resistant corn hybrids, apply fungicides in early stages of treatement"
                            url = "https://extension.umn.edu/corn-pest-management/common-rust-corn"
                        } else if x.identifier == "Corn - Healthy" {
                            problemLabel.text = "No problem! Healthy Corn"
                            treatmentLabel.text = "None needed, but a nice pot of popcorn wouldn't hurt!"
                            url = "https://www.simplyrecipes.com/recipes/perfect_popcorn/"
                        } else if x.identifier == "Corn - Leaf Spot" {
                            problemLabel.text = "Caused by the fungus Bipolaris zeicola, leaves black mold on kernels and red spots on leaves."
                            treatmentLabel.text = "Resistant hybrids and inbreds are suggested, crop rotation will increase resistancy"
                            url = "https://cropprotectionnetwork.org/resources/articles/diseases/northern-corn-leaf-spot-of-corn"
                        } else if x.identifier == "Corn - Northern Leaf Blight" {
                            problemLabel.text = "Caused by Exserohilum turcicum, the anamorph of the ascomycete Setosphaeria turcica."
                            treatmentLabel.text = "Use hybrid planting to build risistance and foliar fungacides."
                            url = "https://en.wikipedia.org/wiki/Northern_corn_leaf_blight"
                        } else if x.identifier == "Grape - Black Rot" {
                            problemLabel.text = "Fungal infection caused by Guignardia bidwellii, leasions created on leaves"
                            treatmentLabel.text = "Plant rot resistant plants to build immunity, plant in sunny environemtns that allow good air movement, make sure plants dry quickly"
                            url = "https://ohioline.osu.edu/factsheet/plpath-fru-24"
                        } else if x.identifier == "Grape - Black Rot" {
                            problemLabel.text = "Fungal infection caused by Guignardia bidwellii, leasions created on leaves"
                            treatmentLabel.text = "Plant rot resistant plants to build immunity, plant in sunny environemtns that allow good air movement, make sure plants dry quickly"
                            url = "https://ohioline.osu.edu/factsheet/plpath-fru-24"
                        } else if x.identifier == "Grape - Black Rot" {
                            problemLabel.text = "Fungal infection caused by Guignardia bidwellii, leasions created on leaves"
                            treatmentLabel.text = "Plant rot resistant plants to build immunity, plant in sunny environemtns that allow good air movement, make sure plants dry quickly"
                            url = "https://ohioline.osu.edu/factsheet/plpath-fru-24"
                        } else if x.identifier == "Grape - Esca" {
                            problemLabel.text = "Trunk disease caused by a variety of fungi, caused by intensive pruning, frost, and more"
                            treatmentLabel.text = "Not much is known about the disease, but remove all infected plants and regrow rot resistant species"
                            url = "http://ipm.ucanr.edu/PMG/r302100611.html"
                        } else if x.identifier == "Grape - Healthy" {
                            problemLabel.text = "No problem! Healthy Grape!"
                            treatmentLabel.text = "None needed, but a pastry wouldn't hurt!"
                            url = "https://www.marthastewart.com/315438/grape-tarts"
                        } else if x.identifier == "Grape - Leaf Blight" {
                            problemLabel.text = "Fungal infections attacking grape leaves"
                            treatmentLabel.text = "Apply dormant sprays (lime sulfur), cur out diseased plants, keep plants dry"
                            url = "https://www.goodfruit.com/11-tips-to-beat-grape-fungal-diseases/"
                        } else if x.identifier == "Orange - Haunglongbing" {
                            problemLabel.text = "Bacterial infection causing yellowing, blotching, leaf drop, etc."
                            treatmentLabel.text = "Spray with citrus nutritional spray"
                            url = "https://www.amazon.com/Southern-Ag-01902-Citrus-Nutritional/dp/B00A51Y8ZM/ref=asc_df_B00A51Y8ZM/?tag=hyprod-20&linkCode=df0&hvadid=193139379506&hvpos=&hvnetw=g&hvrand=4298401186239593828&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9032020&hvtargid=pla-310724743333&psc=1"
                        } else if x.identifier == "Peach - Bacterial Spot" {
                            problemLabel.text = "Bacterial infection from Xanthomonas campestris, resulting in loss of fruit, and weaken trees"
                            treatmentLabel.text = "Remove all unheathly plants and plant resistant varieties such as: Belle of Georgia, Biscoe, etc"
                            url = "https://www.gardeningknowhow.com/edible/fruits/peach/bacterial-spot-on-peach-trees.htm"
                        } else if x.identifier == "Peach - Healthy" {
                            problemLabel.text = "No problem - Healthy Peach!"
                            treatmentLabel.text = "None needed, however a peach cobbler sounds good!"
                            url = "https://www.myrecipes.com/recipe/easy-peach-cobbler"
                        } else if x.identifier == "Potato - Early Blight" {
                            problemLabel.text = "Fungal infection caused by spores of infestans which spread throught the wind"
                            treatmentLabel.text = "Plant disease free plants, keep plants in an open area with suffiecient space between plants, keep plants well watered"
                            url = "https://www.thompson-morgan.com/how-to-stop-potato-blight"
                        } else if x.identifier == "Potato - Healthy" {
                            problemLabel.text = "No problem - Healthy Potatoes!"
                            treatmentLabel.text = "None needed, but learn more about a potato treat!"
                            url = "https://www.allrecipes.com/recipe/24771/basic-mashed-potatoes/"
                        } else if x.identifier == "Potato - Late Blight" {
                            problemLabel.text = "Fungal infection caused by spores of infestans which spread throught the wind in later months"
                            treatmentLabel.text = "Plant disease-free plants, keep plants in an open area with suffiecient space between plants, keep plants well watered"
                            url = "https://www.thompson-morgan.com/how-to-stop-potato-blight"
                        } else if x.identifier == "Raspberry - Healthy" {
                            problemLabel.text = "No problem - Healthy Raspberry"
                            treatmentLabel.text = "None needed - try this pastry!"
                            url = "https://sallysbakingaddiction.com/raspberry-danish-braid/"
                        } else if x.identifier == "Soybean - Healthy" {
                            problemLabel.text = "No problem - Healthy Soybeans"
                            treatmentLabel.text = "None needed - try this soybean treat!"
                            url = "https://food.ndtv.com/recipe-masala-soybeans-98747"
                        } else if x.identifier == "Squash - Powdery Mildew" {
                            problemLabel.text = "Fungal infection causing leaves to die, resulting in lack of nutrients"
                            treatmentLabel.text = "Sulfur/Stylet oil products are good fro control, along with neem oil, crop rotation, and destruction of diseased plants"
                            url = "https://www.gardeningknowhow.com/edible/vegetables/squash/powdery-mildew-in-squash.htm"
                        } else if x.identifier == "Strawberry - Healthy" {
                            problemLabel.text = "No problem - Healthy Strawberry"
                            treatmentLabel.text = "None needed - try this strawberry pastry!"
                            url = "https://www.tastesoflizzyt.com/easy-strawberry-turnovers/"
                        } else if x.identifier == "Strawberry - Leaf Scorch" {
                            problemLabel.text = "Fungal infection from Diplocarpon Earliana, causing purplish blemishes that make leaves fall of plant"
                            treatmentLabel.text = "Proper garden sanitation - remove all diseased plants and grow resistant species "
                            url = "https://www.gardeningknowhow.com/edible/fruits/strawberry/strawberries-with-leaf-scorch.htm"
                        } else if x.identifier == "Tomato - Bacterial Spot" {
                            problemLabel.text = "Variety of bacterial infections that can cause plant death"
                            treatmentLabel.text = "Remove all diseased plants and replant healthy plants in a different location"
                            url = "https://hort.extension.wisc.edu/articles/bacterial-spot-of-tomato/"
                        } else if x.identifier == "Tomato - Early Blight" {
                            problemLabel.text = "Fungal infection caused by Alternaria Solanica - brought by poorly nourished plants "
                            treatmentLabel.text = "Remove all garden crop residue, rotate crops when possible, space plants for air circulation, make plants dry"
                            url = "https://www.pesches.com/blogs/news/how-to-fight-early-blight"
                        } else if x.identifier == "Tomato - Healthy" {
                            problemLabel.text = "No problem - Healthy Tomato!"
                            treatmentLabel.text = "None needed, but try this fun treat!"
                            url = "https://www.foodnetwork.com/recipes/ree-drummond/caprese-salad-recipe-3381696"
                        } else if x.identifier == "Tomato - Late Blight" {
                            problemLabel.text = "Fungal infection caused by Alternaria Solanica - brought by poorly nourished plants "
                            treatmentLabel.text = "Remove all garden crop residue, rotate crops when possible, space plants for air circulation, make plants dry"
                            url = "https://www.pesches.com/blogs/news/how-to-fight-early-blight"
                        } else if x.identifier == "Tomato - Leaf Mold" {
                            problemLabel.text = "Caused by the fungus Passalora fulva - not known to be pathogenic on any plant other than tomato."
                            treatmentLabel.text = "Plant resistant strands of tomato plants, rotate plants"
                            url = "https://extension.umn.edu/diseases/leaf-mold-tomato"
                        } else if x.identifier == "Tomato - Mosiac Virus" {
                            problemLabel.text = "Fungal infection causing mottled light and dark green on misformed leaves"
                            treatmentLabel.text = "Avoid planting in areas where dead tomatoes are in soil, avoid using tobacco products around plants"
                            url = "https://extension.umn.edu/diseases/tomato-mosaic-virus-and-tobacco-mosaic-virus"
                        } else if x.identifier == "Tomato - Septoria Leaf Spot" {
                            problemLabel.text = "Fungal infection Septoria lycopersici caused in wet, humid areas"
                            treatmentLabel.text = "Removed diseased leaves, improve air circulation around plants, mulch around base of plants, change watering style"
                            url = "https://www.missouribotanicalgarden.org/gardens-gardening/your-garden/help-for-the-home-gardener/advice-tips-resources/pests-and-problems/diseases/fungal-spots/septoria-leaf-spot-of-tomato.aspx"
                        } else if x.identifier == "Tomato - Spider Mite" {
                            problemLabel.text = "Millions of microscopic spiders attack the plant, cutting its nutrients supply"
                            treatmentLabel.text = "Plant tomatoes in warm area, apply diatomaceous earth soil around plants"
                            url = "https://www.wikihow.com/Prevent-Spider-Mites-on-Tomato-Plants"
                        } else if x.identifier == "Tomato - Target Spot" {
                            problemLabel.text = "Fungal infection of Corynespora cassiicola reducing the yield of tomatoes"
                            treatmentLabel.text = "Improve airflow by spreading plants out, rotate plants, regular use of fungacides"
                            url = "https://www.seminis-us.com/resources/agronomic-spotlights/target-spot-of-tomato/"
                        } else if x.identifier == "Tomato - Yellow Leaf Curl Virus" {
                            problemLabel.text = "Virus causing stunted growth of tomato plants"
                            treatmentLabel.text = "Use resistant varieties, cover plants with fine mesh, practice weed management "
                            url = "https://www2.ipm.ucanr.edu/agriculture/tomato/tomato-yellow-leaf-curl/"
                        }
                        
                        if x.confidence*100 < 50 {
                            self.confidecne = Int((100 - (x.confidence*100)))
                            accuracyLabel.text = ("Accuracy: \(confidecne)%")
                        } else {
                            self.confidecne = Int((x.confidence*100))
                            accuracyLabel.text = ("Accuracy: \(confidecne)%")
                        }
                        
                        break
                    } else {
                        plantDiseaseLabel.text = "No \(selectedPlant) Leaf Detected"
                        accuracyLabel.text = "Accuracy: Not Applicable"
                        problemLabel.text = "No leaf detected in the photo"
                        treatmentLabel.text = "Retake photo with leaf in good lighting"
                    }
                }
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try! handler.perform([request])
        } catch {
        }
    }
    
    @IBAction func learnMorePressed(_ sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: url) as! URL)
    }
    
        
}
