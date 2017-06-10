using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//using Fincific17;

namespace Fincific17.Services
{
	public class ProfileService
	{
		#region Utilities

		/// <summary>Convert from ProfileModel to Profile.</summary>
		/// <param name="pm">The ProfileModel that gets implicitly converted to a Profile class.</param>
		private static Data.Profile ConvertToDataProfile(Domain.Profile p)
		{
			if (p == null) { return null; }
			return new Data.Profile()
			{
				Id = p.Id,
				AspNetUserId = p.AspNetUserId,
				FirstName = p.FirstName,
				NickName = p.NickName,
				LastName = p.LastName
			};
		}

		/// <summary>Convert from Data.Profile to Domain.Profile.</summary>
		/// <param name="p">The Data.Profile class that gets implicitly converted to a Domain.Profile class.</param>
		private static Domain.Profile ConvertToDomainProfile(Data.Profile p)
		{
			if (p == null) { return null; }
			return new Domain.Profile()
			{
				Id = p.Id,
				AspNetUserId = p.AspNetUserId,
				FirstName = p.FirstName,
				LastName = p.LastName,
				NickName = p.NickName
			};
		}

		#endregion // Utilities

		public int AddProfile(Domain.Profile profile)
		{
			Data.Profile newDataProfile = ConvertToDataProfile(profile);
			int newProfileId = 0;
			using (var dc = new Data.FinancificDataContext())
			{
				dc.Profiles.InsertOnSubmit(newDataProfile);
				dc.SubmitChanges();
				newProfileId = newDataProfile.Id;
			}
			return newProfileId;
		}

		/// <summary>Note: when no profile exists with the specified <paramref name="aspNetUserId"/>,
		/// then a new Domain.Profile is returned with its AspNetUserId set to the requested aspNetUserId.
		/// </summary>
		/// <param name="aspNetUserId"></param>
		/// <returns></returns>
		public Domain.Profile GetProfileByAspNetUserId(string aspNetUserId)
		{
			using (var dc = new Data.FinancificDataContext())
			{
				Data.Profile profile = dc.Profiles.Where(w => w.AspNetUserId == aspNetUserId).FirstOrDefault();
				if (profile == null) { return new Domain.Profile() { AspNetUserId = aspNetUserId }; }
				return ConvertToDomainProfile(profile);
			}
		}

		/// <summary>
		/// Note: when no profile exists with the specified <paramref name="aspNetUserId"/>, then null is currently returned.
		/// (Note that this differs from the functionality of GetProfileByAspNetUserId(), which never returns null.)
		/// </summary>
		/// <param name="aspNetUserId"></param>
		/// <returns></returns>
		public Domain.Profile GetProfileByProfileId(int profileId)
		{
			using (var dc = new Data.FinancificDataContext())
			{
				Data.Profile profile = dc.Profiles.Where(w => w.Id == profileId).FirstOrDefault();
				return ConvertToDomainProfile(profile);
			}
		}

		public void UpdateProfile(Domain.Profile profile)
		{
			if (profile.Id == 0) { AddProfile(profile); return; }

			using (var dc = new Data.FinancificDataContext())
			{
				Data.Profile u = dc.Profiles.Where(f => f.Id == profile.Id).FirstOrDefault();
				u.FirstName = profile.FirstName;
				u.NickName  = profile.NickName;
				u.LastName  = profile.LastName;
				dc.SubmitChanges();
			}
		}

	} // public class ProfileService

} // namespace Fincific17.Services0
