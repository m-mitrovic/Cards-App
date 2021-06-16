//
//  ContactsCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-10.
//

import SwiftUI

struct ContactsCardView: View {
    var card: Card
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ExpandedView()
                VStack {
                    if card.Contacts.count == 0 {
                        Text("No contacts added.").foregroundColor(card.TextColor.color())
                    } else {
                        LazyVGrid(columns: layout, alignment: .center, content: {
                            ForEach(card.Contacts.indices, id: \.self) { i in
                               // Rectangle().fill(card.TextColor.color()).frame(height: (geo.size.height-45)/2)
                                VStack(alignment: .center, spacing: 3) {
                                    if card.Contacts[i].imageData == nil {
                                        CustomContactsIcon(contact: card.Contacts[i], card: card, size: (geo.size.width-60)/5)
                                    } else {
                                        Image(uiImage: card.contactsImage(i)).resizable().scaledToFit().frame(width: (geo.size.width-60)/5, height: (geo.size.width-60)/5).clipShape(Circle())
                                    }
                                    Text(card.Contacts[i].name).foregroundColor(card.TextColor.color()).lineLimit(1).font(.system(size: 12))
                                }.onTapGesture {
                                    contactsAction(card.Contacts[i])
                                }
                            }
                        }).padding(.horizontal, 8)
                    }
                }
            }.background(card.Background.color())
        }
    }
    
    /** Allows user to call, message, FaceTime, and email. Smartly adapts with whichever contacts are given.*/
    func contactsAction(_ contact: Contact) {
        let alert = UIAlertController(title: contact.name, message: nil, preferredStyle: .actionSheet)
        
        if contact.phoneNumber != nil {
            let callAction = UIAlertAction(title: "Call", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "tel://\(contact.phoneNumber!)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                }
            })
            callAction.setValue(UIImage(systemName: "phone.fill"), forKey: "image")
            alert.addAction(callAction)
            
            let messageAction = UIAlertAction(title: "Message", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "sms://\(contact.phoneNumber!)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            })
            messageAction.setValue(UIImage(systemName: "message.fill"), forKey: "image")
            alert.addAction(messageAction)
        }
        
        let facetimeAction = UIAlertAction(title: "FaceTime", style: .default, handler: { (UIAlertAction) in
            let facetimeCaller = contact.phoneNumber != nil ? contact.phoneNumber! : contact.email
            if let url = URL(string: "facetime://\(facetimeCaller ?? "")"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
        facetimeAction.setValue(UIImage(systemName: "video.fill"), forKey: "image")
        alert.addAction(facetimeAction)
        
        let facetimeAudioAction = UIAlertAction(title: "FaceTime Audio", style: .default, handler: { (UIAlertAction) in
            let facetimeCaller = contact.phoneNumber != nil ? contact.phoneNumber! : contact.email
            if let url = URL(string: "facetime-audio://\(facetimeCaller ?? "")"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
        facetimeAudioAction.setValue(UIImage(systemName: "phone.fill"), forKey: "image")
        alert.addAction(facetimeAudioAction)
        
        if contact.email != nil {
            let emailAction = UIAlertAction(title: "Email", style: .default, handler: { (UIAlertAction) in
                if let url = URL(string: "mailto:\(contact.email!)?subject=sdf") {
                    UIApplication.shared.open(url)
                }
            })
            emailAction.setValue(UIImage(systemName: "envelope.fill"), forKey: "image")
            alert.addAction(emailAction)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction)in
                // User dismissed
        }))
        
        topMostController()?.present(alert, animated: true, completion: nil)
    }
}

/** Expand the background to make it fit the enire frame */
struct ExpandedView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Spacer()
            }
        }
    }
}

/** If contacts image is nil, create a simple custom one with contact's initials */
struct CustomContactsIcon: View {
    var contact: Contact
    var card: Card
    var size: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle().fill(card.TextColor.color()).frame(width: size)
            Text(contact.name.prefix(1)).font(.system(size: size/2.7, weight: .bold)).foregroundColor(card.Background.color())
        }.frame(width: size, height: size)
    }
}

/** Helper which finds the highest view controller currently in use */
func topMostController() -> UIViewController? {
    guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
        return nil
    }

    var topController = rootViewController

    while let newTopController = topController.presentedViewController {
        topController = newTopController
    }

    return topController
}
