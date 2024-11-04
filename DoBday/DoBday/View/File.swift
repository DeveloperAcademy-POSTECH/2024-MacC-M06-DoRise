//
//  File.swift
//  DoBday
//
//  Created by chanu on 11/4/24.
//


 HStack {
                        ForEach(bday.relationshipTag, id: \.self) { tag in
                            Text(tag)
                                .font(.bday_c2Emphasized)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.yellow.opacity(0.3))
                                .cornerRadius(20)
                        }
                    }